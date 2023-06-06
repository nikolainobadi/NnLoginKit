//
//  AccountLinkDataModel.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import Foundation

final class AccountLinkDataModel: ObservableObject {
    @Published var showingEmailView = false
    
    private let auth: NnAccountLinkAuth
    
    init(auth: NnAccountLinkAuth) {
        self.auth = auth
    }
}


// MARK: - ViewModel
extension AccountLinkDataModel {
    var passwordEmail: String? { "tester@gmail.com" }
    var appleEmail: String? { nil }
    var googleEmail: String? { nil }
    
    var accountLinkTypes: [AccountLinkType] {
        return [.email(passwordEmail), .apple(appleEmail), .google(googleEmail)]
    }
    
    func performLinkAction(for linkType: AccountLinkType) async throws {
        guard linkType.email == nil else { return try await unlinkAccount(linkType) }
        
        switch linkType {
        case .email:
            try await showEmailLogin()
        case .apple:
            try await appleAccountLink()
        case .google:
            try await googleAccountLink()
        }
    }
}


// MARK: - Private Methods
private extension AccountLinkDataModel {
    @MainActor func showEmailLogin() async throws {
        showingEmailView = true
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
