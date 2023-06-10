//
//  NnDisplayableLoginError.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import Foundation

/// `NnDisplayableLoginError` is a public protocol that represents errors thrown during the login process.
/// Errors conforming to this protocol can provide a title and a message that will be displayed to the user.
///
/// This protocol is particularly useful for providing user-friendly error information for non-validation
/// errors (e.g., network errors, service errors, etc.). Email and password validation errors are handled
/// internally by NnLoginKit and displayed directly in the login view.
public protocol NnDisplayableLoginError: Error {
    /// The title of the error. This is typically a short string that summarizes the error.
    var title: String { get }
    
    /// The message of the error. This is typically a longer string that describes the error in more detail.
    var message: String { get }
}

