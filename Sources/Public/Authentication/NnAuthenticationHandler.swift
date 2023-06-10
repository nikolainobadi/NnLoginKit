//
//  NnAuthenticationHandler.swift
//  
//
//  Created by Nikolai Nobadi on 6/3/23.
//

import UIKit

/// `NnAuthenticationHandler` is a public enum that handles creating necessary information for authentication processes.
/// It is specifically designed to facilitate Firebase Authentication, providing mechanisms for retrieving and creating
/// credentials for different login methods.
public enum NnAuthenticationHandler { }

public extension NnAuthenticationHandler {
    /// Asynchronously retrieves the password for email authentication by displaying an alert with a text field.
    /// This information can then be used in Firebase Authentication.
    ///
    /// - Returns: A string containing the entered password.
    static func getPasswordForEmailAuthentication() async -> String {
        return await showPasswordAlert()
    }
    
    /// Asynchronously creates an `AppleTokenInfo` instance using the `AppleSignInCoordinator` object.
    /// The returned information is suitable for use with Firebase Authentication.
    ///
    /// - Throws: An error if the creation of the `AppleTokenInfo` fails.
    /// - Returns: An optional `AppleTokenInfo` instance containing Apple token information.
    static func createAppleTokenInfo() async throws -> AppleTokenInfo? {
        return try await AppleSignInCoordinator().createAppleTokenInfo()
    }
    
    /// Asynchronously creates a `GoogleTokenInfo` instance using the `GoogleSignInHandler` object.
    /// The returned information is suitable for use with Firebase Authentication.
    ///
    /// - Throws: An error if the creation of the `GoogleTokenInfo` fails.
    /// - Returns: An optional `GoogleTokenInfo` instance containing Google token information.
    static func createGoogleTokenInfo() async throws -> GoogleTokenInfo? {
        return try await GoogleSignInHandler.createGoogleIdToken()
    }
}

@MainActor
public extension NnAuthenticationHandler {
    /// Asynchronously shows a reauthentication alert with a specified title and message.
    /// This is particularly useful in scenarios where Firebase Authentication requires a recent login.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    static func showReauthenticationAlert(title: String, message: String) async {
        return await withCheckedContinuation { continuation in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { _ in
                return continuation.resume()
            }
            
            alertController.addAction(action)
            alertController.showAlert()
        }
    }
    
    /// Asynchronously shows a password alert requesting the user to enter a password associated with their email.
    /// The returned password can be used for Firebase Authentication.
    ///
    /// - Returns: A string containing the entered password.
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
    /// Shows the alert in the topmost UIViewController.
    /// This method is used to display alerts for various authentication tasks, such as password retrieval.
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
