//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 6/3/23.
//

import UIKit

public enum AuthenticationHandler {
    static func getPasswordForEmailAuthentication() async -> String {
        return await showPasswordAlert()
    }
    
    static func createAppleTokenInfo() async throws -> AppleTokenInfo {
//        let tokentInfo = try await AppleSignInCoordinator().createAppleTokenInfo()
        
        ("", "")
    }
    
    static func createGoogleTokenInfo() async throws -> GoogleTokenInfo? {
        try await GoogleSignInHandler.createGoogleIdToken()
    }
}

@MainActor
public extension AuthenticationHandler {
    static func showReauthenticationAlert(title: String, message: String) async {
        return await withCheckedContinuation { continuation in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default)
            
            alertController.addAction(action)
            alertController.showAlert()
        }
    }
    
    private static func showPasswordAlert() async -> String {
        let message = "Please enter the password associated with your email."
        
        return await withCheckedContinuation { continuation in
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                let password = alertController.textFields?.first?.text ?? ""
                continuation.resume(returning: password)
            }
            alertController.addAction(action)
            alertController.addTextField { (textField) in
                textField.placeholder = "Password"
                textField.isSecureTextEntry = true
                textField.autocorrectionType = .no
                textField.autocapitalizationType = .none
            }
            alertController.showAlert()
        }
    }
}


// MARK: - Dependencies
internal extension UIAlertController {
    func showAlert() {
        let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(self, animated: true, completion: nil)
        }
    }
}

