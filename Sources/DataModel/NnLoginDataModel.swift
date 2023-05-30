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
    var appTitle: String { "App Title" }
    
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
}


// MARK: - Dependencies
public protocol NnLoginAuth {
    func guestSignIn() async throws
    func emailLogin(email: String, password: String) async throws
    func appleSignIn(tokenInfo: AppleTokenInfo) async throws
    func googleSignIn(tokenInfo: GoogleTokenInfo) async throws
}


