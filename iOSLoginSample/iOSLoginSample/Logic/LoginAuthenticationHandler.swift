//
//  LoginAuthenticationHandler.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 6/12/23.
//

import NnLoginKit

final class LoginAuthenticationHandler { }


// MARK: - Auth
extension LoginAuthenticationHandler: NnLoginAuth {
    func guestLogin() async throws {
        
    }
    
    func guestSignIn() async throws {
        
    }
    
    func emailLogin(email: String, password: String) async throws {
        
    }
    
    func appleSignIn(tokenInfo: NnLoginKit.AppleTokenInfo) async throws {
        
    }
    
    func googleSignIn(tokenInfo: NnLoginKit.GoogleTokenInfo) async throws {
        
    }
    
    func sendResetEmail(email: String) async throws {
    
    }
}
