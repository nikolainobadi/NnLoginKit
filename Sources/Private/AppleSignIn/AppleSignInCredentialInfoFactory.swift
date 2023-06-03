//
//  AppleSignInCredentialInfoFactory.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import AuthenticationServices

enum AppleSignInCredentialInfoFactory {
    static func convertCredential(auth: ASAuthorization, currentNonce: String?) -> AppleTokenInfo? {
        guard let appleIDCredential = auth.credential as? ASAuthorizationAppleIDCredential else { return nil }
        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
            fatalError("Unable to fetch identity token")
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            fatalError("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
        }
        
        return (idTokenString, nonce)
    }
}

