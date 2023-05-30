//
//  NnLoginFieldError.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import Foundation

enum NnLoginFieldError: Error {
    case email
    case password
    case confirm
}


// MARK: - DisplayableLoginError
extension NnLoginFieldError: DisplayableLoginError {
    var title: String {
        switch self {
        case .email: return "Invalid email"
        case .password: return "Invalid password"
        case .confirm: return "Mismatched passwords"
        }
    }
    
    var message: String {
        switch self {
        case .email: return "Please enter a valid email"
        case .password: return "Please enter a password with at least 6 characters"
        case .confirm: return "Please ensure your passwords match"
        }
    }
}
