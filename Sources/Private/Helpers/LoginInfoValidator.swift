//
//  LoginInfoValidator.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import Foundation

enum LoginInfoValidator {
    static func validateInfo(_ info: LoginInfo, isSignUp: Bool) throws {
        guard emailIsValid(info.email) else { throw NnLoginFieldError.email }
        guard passwordIsValid(info.password) else { throw NnLoginFieldError.password }
        
        if isSignUp {
            guard passwordsMatch(password: info.password, confirm: info.confirm) else { throw NnLoginFieldError.confirm }
        }
    }
    
    static func validateInfo(email: String, password: String, confirm: String? = nil) throws {
        guard emailIsValid(email) else { throw NnLoginFieldError.email }
        guard passwordIsValid(password) else { throw NnLoginFieldError.password }
        
        if let confirm = confirm {
            guard passwordsMatch(password: password, confirm: confirm) else { throw NnLoginFieldError.confirm }
        }
    }
}


// MARK: - Private
private extension LoginInfoValidator {
    static func emailIsValid(_ email: String) -> Bool {
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: email)
    }
    static func passwordIsValid(_ password: String) -> Bool { password != "" && password.count > 5 }
    static func passwordsMatch(password: String, confirm: String) -> Bool { password == confirm }
}
