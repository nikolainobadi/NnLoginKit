//
//  AccountLinkDataModel.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import Foundation

final class AccountLinkDataModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirm = ""
    @Published var showingEmailSignUp = false
    @Published var accountLinkTypes = [AccountLinkType]()
    @Published var selectedAccountLink: AccountLinkType?
    
    private let auth: NnAccountLinkAuth
    
    init(auth: NnAccountLinkAuth) {
        self.auth = auth
    }
}


// MARK: - ViewModel
extension AccountLinkDataModel {
    var canUnlink: Bool {
        accountLinkTypes.compactMap({ $0.email }).count > 1
    }

    func loadData() {
        accountLinkTypes = auth.loadAvailableAccountLinkTypes().sorted(by: { $0.id < $1.id })
    }
    
    func performEmailSignUpAction() async throws {
        guard let selectedAccountLink = selectedAccountLink else { return }
        
        switch selectedAccountLink {
        case .email(_, let passwordAccountLink):
            try LoginInfoValidator.validateInfo(email: email, password: password, confirm: confirm)
            try await passwordAccountLink(((email, password)))
        default:
            break
        }
    }
    
    func performLinkAction(for linkType: AccountLinkType) async throws {
        guard linkType.email == nil else { return try await unlinkAccount(linkType) }
        
        switch linkType {
        case .email:
            await showEmailSignUp(linkType)
        case .apple(_, let appleLinkAction):
            try await appleAccountLink(appleLinkAction)
        case .google(_, let googleLinkAction):
            try await googleAccountLink(googleLinkAction)
        }
        
        await finished()
    }
}


// MARK: - MainActor
@MainActor
private extension AccountLinkDataModel {
    func showEmailSignUp(_ linkType: AccountLinkType) {
        self.showingEmailSignUp = true
        self.selectedAccountLink = linkType
    }
    
    func finished() {
        loadData()
        resetTextFieldValues()
    }
}


// MARK: - Private Methods
private extension AccountLinkDataModel {
    func appleAccountLink(_ appleLinkAction: AccountLinkType.AppleLinkAction) async throws {
        if let tokenInfo = try await AppleSignInCoordinator().createAppleTokenInfo() {
            try await appleLinkAction(tokenInfo)
        }
    }
    
    func googleAccountLink(_ googleLinkAction: AccountLinkType.GoogleLinkAction) async throws {
        if let tokenInfo = try await GoogleSignInHandler.createGoogleIdToken() {
            try await googleLinkAction(tokenInfo)
        }
    }
    
    func unlinkAccount(_ linkType: AccountLinkType) async throws {
        try await auth.unlink(fromProvider: linkType.providerId)
    }
    
    func resetTextFieldValues() {
        email = ""
        password = ""
        confirm = ""
    }
}
