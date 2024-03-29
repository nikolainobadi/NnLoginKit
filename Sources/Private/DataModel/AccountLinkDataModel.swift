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
    @Published var isLoading = false
    @Published var showingEmailSignUp = false
    @Published var accountLinkTypes = [NnAccountLinkType]()
    @Published var selectedAccountLink: NnAccountLinkType?
    
    private let auth: NnAccountLinkAuth
    private let setAuthenticationStatus: ((Bool) -> Void)?
    
    init(auth: NnAccountLinkAuth, setAuthenticationStatus: ((Bool) -> Void)?) {
        self.auth = auth
        self.setAuthenticationStatus = setAuthenticationStatus
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
        await configureLoading(isLoading: true)
        
        do {
            switch selectedAccountLink {
            case .email(_, let passwordAccountLink):
                try LoginInfoValidator.validateInfo(email: email, password: password, confirm: confirm)
                try await passwordAccountLink(((email, password)))
            default:
                break
            }
            
            await configureLoading(isLoading: false)
        } catch {
            await configureLoading(isLoading: false)
            throw error
        }
    }
    
    func performLinkAction(for linkType: NnAccountLinkType) async throws {
        do {
            await configureLoading(isLoading: true)
            guard linkType.email == nil else { return try await unlinkAccount(linkType) }
            
            switch linkType {
            case .email:
                await showEmailSignUp(linkType)
            case .apple(_, let appleLinkAction):
                try await appleAccountLink(appleLinkAction)
            case .google(_, let googleLinkAction):
                try await googleAccountLink(googleLinkAction)
            }
            
            await finished() // handles loading
        } catch {
            await configureLoading(isLoading: false)
            throw error
        }
    }
}


// MARK: - MainActor
@MainActor
private extension AccountLinkDataModel {
    func configureLoading(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func showEmailSignUp(_ linkType: NnAccountLinkType) {
        self.showingEmailSignUp = true
        self.selectedAccountLink = linkType
    }
    
    func finished() {
        loadData()
        resetTextFieldValues()
        isLoading = false
    }
}


// MARK: - Private Methods
private extension AccountLinkDataModel {
    func appleAccountLink(_ appleLinkAction: NnAccountLinkType.AppleLinkAction) async throws {
        setAuthenticationStatus?(true)
        if let tokenInfo = try await AppleSignInCoordinator().createAppleTokenInfo() {
            try await appleLinkAction(tokenInfo)
        }
    }
    
    func googleAccountLink(_ googleLinkAction: NnAccountLinkType.GoogleLinkAction) async throws {
        setAuthenticationStatus?(true)
        if let tokenInfo = try await GoogleSignInHandler.createGoogleIdToken() {
            try await googleLinkAction(tokenInfo)
        }
    }
    
    func unlinkAccount(_ linkType: NnAccountLinkType) async throws {
        do {
            try await auth.unlink(fromProvider: linkType.providerId)
            await configureLoading(isLoading: false)
            await finished()
        } catch {
            await configureLoading(isLoading: false)
            throw error
        }
    }
    
    func resetTextFieldValues() {
        email = ""
        password = ""
        confirm = ""
    }
}
