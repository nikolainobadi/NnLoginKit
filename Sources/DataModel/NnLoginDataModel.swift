//
//  NnLoginDataModel.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI
import Foundation

public final class NnLoginDataModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirm = ""
    @Published var error: Error?
    @Published var isLogin = false
    @Published var isLoading = false
    @Published var loginFieldError: NnLoginFieldError?
    
    private let actions: NnLoginActions
    private let config: NnLoginViewConfig
    
    public init(actions: NnLoginActions, config: NnLoginViewConfig = NnLoginViewConfig()) {
        self.actions = actions
        self.config = config
    }
}


// MARK: - View Model
public extension NnLoginDataModel {
    var title: String { isLogin ? "Login" : "Sign Up" }
    var accountButtonText: String { "\(isLogin ? "Don't" : "Already") have an account?" }
    var viewColors: NnLoginViewConfig.ColorOptions { config.colors }
    var canShowGuestLogin: Bool { options.enableGuestLogin }
    var canShowResetPassword: Bool { options.enableResetPassword }
    var canShowAccountButton: Bool { options.enableToggleLoginType }
    
    func login(shouldSkip: Bool = false) {
        isLoading = true
        loginFieldError = nil
        
        Task {
            do {
                try await loginOrSignUp(shouldSkip: shouldSkip)
                await stopLoading()
            } catch {
                await stopLoading()
                await showError(error)
            }
        }
    }
}


// MARK: - Private Helpers
private extension NnLoginDataModel {
    var options: NnLoginViewConfig.LoginOptions { config.options }
    
    func loginOrSignUp(shouldSkip: Bool) async throws {
        if shouldSkip {
            try await actions.guestLogin()
        } else {
            try LoginInfoValidator.validateInfo(email: email, password: password, confirm: isLogin ? nil : confirm)
            
            if isLogin {
                try await actions.login(email: email, password: password)
            } else {
                try await actions.signUp(email: email, password: password)
            }
        }
    }
}


// MARK: - MainActor
private extension NnLoginDataModel {
    @MainActor func stopLoading() { self.isLoading = false }
    @MainActor func showError(_ error: Error?) {
        if let loginFieldError = error as? NnLoginFieldError {
            self.loginFieldError = loginFieldError
        } else {
            self.error = error
        }
    }
}


// MARK: - Dependencies
public protocol NnLoginActions {
    func guestLogin() async throws
    func login(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
}

enum NnLoginFieldError: Error {
    case email
    case password
    case confirm
    
    var message: String {
        switch self {
        case .email: return "Please enter a valid email"
        case .password: return "Please enter a password with at least 6 characters"
        case .confirm: return "Please ensure your passwords match"
        }
    }
}

public struct NnLoginViewConfig {
    public let colors: ColorOptions
    public let options: LoginOptions
    
    public init(colors: ColorOptions = ColorOptions(), options: LoginOptions = LoginOptions()) {
        self.colors = colors
        self.options = options
    }
}

public extension NnLoginViewConfig {
    struct ColorOptions {
        var title: Color
        var underlinedButtons: Color
        var loginButtonBackground: Color
        var loginButtonText: Color
        var textFieldTint: Color
        var errorText: Color
        var backgroundColor: Color
        
        public init(title: Color = .primary, underlinedButtons: Color = .blue, loginButtonBackground: Color = .primary, loginButtonText: Color = Color(uiColor: .systemBackground), textFieldTint: Color = .blue, errorText: Color = .red, backgroundColor: Color = Color(uiColor: .systemBackground)) {
            self.title = title
            self.underlinedButtons = underlinedButtons
            self.loginButtonBackground = loginButtonBackground
            self.loginButtonText = loginButtonText
            self.textFieldTint = textFieldTint
            self.errorText = errorText
            self.backgroundColor = backgroundColor
        }
    }
    
    struct LoginOptions {
        var enableGuestLogin: Bool
        var enableResetPassword: Bool
        var enableToggleLoginType: Bool
        
        public init(enableGuestLogin: Bool = false, enableResetPassword: Bool = true, enableToggleLoginType: Bool = true) {
            self.enableGuestLogin = enableGuestLogin
            self.enableResetPassword = enableResetPassword
            self.enableToggleLoginType = enableToggleLoginType
        }
    }
}

enum LoginInfoValidator {
    static func validateInfo(email: String, password: String, confirm: String? = nil) throws {
        guard emailIsValid(email) else { throw NnLoginFieldError.email }
        guard passwordIsValid(password) else { throw NnLoginFieldError.password }
        
        if let confirm = confirm {
            guard passwordsMatch(password: password, confirm: confirm) else { throw NnLoginFieldError.confirm }
        }
    }
}


private extension LoginInfoValidator {
    static func emailIsValid(_ email: String) -> Bool {
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: email)
    }
    static func passwordIsValid(_ password: String) -> Bool { password != "" && password.count > 5 }
    static func passwordsMatch(password: String, confirm: String) -> Bool { password == confirm }
}
