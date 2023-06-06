//
//  AccountLinkDataModel.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import Foundation

final class AccountLinkDataModel: ObservableObject {
    @Published var showingEmailView = false
    
    private let actions: AccountLinkActions
    
    init(actions: AccountLinkActions) {
        self.actions = actions
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
        guard linkType.email == nil else { return try await unlinkAccount() }
        
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
        
    }
    
    func googleAccountLink() async throws {
        
    }
    
    func unlinkAccount() async throws {
        
    }
}


// MARK: - Dependencies

