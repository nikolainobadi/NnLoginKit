//
//  AccountLinkDataModel.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import Foundation

final class AccountLinkDataModel: ObservableObject {
    @Published private var appleEmail: String?
    @Published private var googleEmail: String?
    @Published private var passwordEmail: String?
    
    private let auth: NnAccountLinkAuth
    
    init(auth: NnAccountLinkAuth) {
        self.auth = auth
    }
}


// MARK: - ViewModel
extension AccountLinkDataModel {
    var accountLinkTypes: [AccountLinkType] {
        return [.email(nil), .apple(nil), .google(nil)]
    }
    
    func loadEmails() {
        
    }
    
    func performLinkAction(for linkType: AccountLinkType) async throws {
        guard linkType.email == nil else { return try await unlinkAccount(linkType) }
        
        switch linkType {
        case .email:
            await showEmailLogin()
        case .apple:
            try await appleAccountLink()
        case .google:
            try await googleAccountLink()
        }
    }
}


// MARK: - Private Methods
private extension AccountLinkDataModel {
    @MainActor func showEmailLogin() {
        
    }
    
    func appleAccountLink() async throws {
        if let tokenInfo = try await AppleSignInCoordinator().createAppleTokenInfo() {
            try await auth.appleAccountLink(tokenInfo: tokenInfo)
        }
    }
    
    func googleAccountLink() async throws {
        if let tokenInfo = try await GoogleSignInHandler.createGoogleIdToken() {
            try await auth.googleAccountLink(tokenInfo: tokenInfo)
        }
    }
    
    func unlinkAccount(_ linkType: AccountLinkType) async throws {
        switch linkType {
        case .email:
            try await auth.unlinkPasswordEmail()
        case .apple:
            try await auth.unlinkAppleId()
        case .google:
            try await auth.unlinkAppleId()
        }
    }
}
