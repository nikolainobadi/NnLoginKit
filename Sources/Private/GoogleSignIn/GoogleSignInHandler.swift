//
//  GoogleSignInHandler.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import UIKit
import GoogleSignIn

enum GoogleSignInHandler {
    @MainActor static func createGoogleIdToken() async throws -> GoogleTokenInfo? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootVC = window.rootViewController
        else {
            fatalError("There is no rootVC")
        }
        
        do {
            let userAuth = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)
            let user = userAuth.user
            
            guard let idToken = user.idToken else { fatalError("noId token") }
            
            let accessToken = user.accessToken
            
            return (idToken.tokenString, accessToken.tokenString)
        } catch let googleError as GIDSignInError {
            switch googleError.code {
            case .canceled:
                print("User cancelled sign-in, no action required")
                return nil
            default:
                throw googleError
            }
        } catch {
            throw error
        }
    }
}
