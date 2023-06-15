//
//  LoginAuthenticationHandler.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 6/12/23.
//

import NnLoginKit

final class LoginAuthenticationHandler {
    private let login: (String) -> Void
    
    init(login: @escaping (String) -> Void) {
        self.login = login
    }
}


// MARK: - Auth
extension LoginAuthenticationHandler: NnLoginAuth {
    func guestSignIn() async throws {
        login("guestId")
    }
    
    func emailLogin(email: String, password: String) async throws {
        login("email/password id")
    }
    
    func appleSignIn(tokenInfo: NnLoginKit.AppleTokenInfo) async throws {
        login("applieId")
    }
    
    func googleSignIn(tokenInfo: NnLoginKit.GoogleTokenInfo) async throws {
        login("googleId")
    }
    
    func sendResetEmail(email: String) async throws { }
}
