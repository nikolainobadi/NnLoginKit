//
//  LoginViewModel.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import LoginLogic

public struct LoginViewModel {
    
    // MARK: - Private Properties
    private let state: LoginState
    
    private var readyToLogin: Bool {
        state.email != ""
            && state.password != ""
            && emailError == ""
            && passwordError == ""
        
    }
    
    private var readyToSignUp: Bool {
        readyToLogin
            && state.confirm != ""
            && confirmError == ""
    }
    
    
    // MARK: - Init
    public init(_ state: LoginState) {
        self.state = state
    }
}


// MARK: - Public Properties
extension LoginViewModel {
    
    public var title: String {
        isSignUp ? "Sign Up" : "Login"
    }
    
    public var accountButtonTitle: String {
        let prefix = isSignUp ? "Already have" : "Don't have"
        
        return "\(prefix) have an account?"
    }
    
    public var isSignUp: Bool { state.isSignUp }
    
    public var emailError: String {
        Validator.validate(state.email, with: [.validEmail])
    }
    public var passwordError: String {
        Validator.validate(state.password, with: [.validPassword])
    }
    public var confirmError: String {
        if state.confirm == "" || state.password == state.confirm {
            return ""
        }
        
        return "Passwords don't match"
    }
    
    public var ready: Bool {
        isSignUp ? readyToSignUp : readyToLogin
    }
}

