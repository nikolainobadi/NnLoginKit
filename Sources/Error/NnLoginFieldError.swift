//
//  NnLoginFieldError.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import Foundation
import NnSwiftUIDesignHelpers

enum NnLoginFieldError: Error {
    case email
    case password
    case confirm
}

extension NnLoginFieldError: NnError {
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
