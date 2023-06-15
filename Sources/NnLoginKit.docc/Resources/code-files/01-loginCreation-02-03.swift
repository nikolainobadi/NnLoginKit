//
//  LoginAuthenticationHandler.swift
//
//
//  Created by Nikolai Nobadi on 6/12/23.
//

import NnLoginKit

class LoginAuthenticationHandler { }

extension LoginAuthenticationHandler: NnLoginAuth {
    func guestSignIn() async throws {
        // Implementation for guest sign-in.
    }

    func emailLogin(email: String, password: String) async throws {
        // Implementation for email login.
    }

    func sendResetEmail(email: String) async throws {
        // Implementation for sending a reset email.
    }

    func appleSignIn(tokenInfo: AppleTokenInfo) async throws {
        // Implementation for Apple sign-in.
    }

    func googleSignIn(tokenInfo: GoogleTokenInfo) async throws {
        // Implementation for Google sign-in.
    }
}
