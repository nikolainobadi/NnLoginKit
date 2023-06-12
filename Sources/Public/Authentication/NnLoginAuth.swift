//
//  NnLoginAuth.swift
//  
//
//  Created by Nikolai Nobadi on 6/11/23.
//

/// `NnLoginAuth` is a public protocol that defines methods for handling different types of sign-in processes.
///
/// This includes guest sign-in, email/password sign-in, password reset via email, and sign-in with Apple and Google.
public protocol NnLoginAuth {
    /// Signs in a guest user.
    ///
    /// - Throws: An error if the guest sign-in process fails.
    func guestSignIn() async throws
    
    /// Signs in a user with their email and password.
    ///
    /// - Parameters:
    ///   - email: The user's email.
    ///   - password: The user's password.
    ///
    /// - Throws: An error if the email/password sign-in process fails.
    func emailLogin(email: String, password: String) async throws
    
    /// Sends a password reset email to the specified email address.
    ///
    /// - Parameter email: The email address to send the password reset email to.
    ///
    /// - Throws: An error if the process of sending a reset email fails.
    func sendResetEmail(email: String) async throws
    
    /// Signs in a user with their Apple ID.
    ///
    /// - Parameter tokenInfo: A tuple containing information related to the Apple ID token.
    ///
    /// - Throws: An error if the Apple ID sign-in process fails.
    func appleSignIn(tokenInfo: AppleTokenInfo) async throws
    
    /// Signs in a user with their Google account.
    ///
    /// - Parameter tokenInfo: A tuple containing information related to the Google ID token and access token.
    ///
    /// - Throws: An error if the Google sign-in process fails.
    func googleSignIn(tokenInfo: GoogleTokenInfo) async throws
}

