//
//  NnLoginDataModel.swift
//  
//
//  Created by Nikolai Nobadi on 5/29/23.
//

import Foundation

final class NnLoginDataModel: ObservableObject {
    private let auth: NnLoginAuth
    
    init(auth: NnLoginAuth) {
        self.auth = auth
    }
}


// MARK: - ViewModel
extension NnLoginDataModel {
    func guestSignIn() async throws {
        try await auth.guestSignIn()
    }
    
    func emailLogin(email: String, password: String) async throws {
        try await auth.emailLogin(email: email, password: password)
    }
    
    func appleSignIn(tokenInfo: AppleTokenInfo) async throws {
        try await auth.appleSignIn(tokenInfo: tokenInfo)
    }
    
    func googleSignIn(tokenInfo: GoogleTokenInfo?) async throws {
        guard let tokenInfo = tokenInfo else { return }
        
        try await auth.googleSignIn(tokenInfo: tokenInfo)
    }
    
    func sendResetPassword(email: String) async throws {
        try await auth.sendResetEmail(email: email)
    }
}
