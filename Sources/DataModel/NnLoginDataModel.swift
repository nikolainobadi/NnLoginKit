//
//  NnLoginDataModel.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI
import Foundation

struct LoginColorOptions {
    let title: Color
    let detailsText: Color
    let buttonText: Color
    let buttonBackground: Color
    let underlinedButtons: Color
    let viewBackground: Color
    let textFieldTint: Color
    let errorText: Color
    
    init(title: Color = .primary, detailsText: Color = .primary, buttonText: Color = Color(uiColor: .systemBackground), buttonBackground: Color = .primary, underlinedButtons: Color = .primary, viewBackground: Color = Color(uiColor: .systemBackground), textFieldTint: Color = .primary, errorText: Color = .red) {
        
        self.title = title
        self.detailsText = detailsText
        self.buttonText = buttonText
        self.buttonBackground = buttonBackground
        self.underlinedButtons = underlinedButtons
        self.viewBackground = viewBackground
        self.textFieldTint = textFieldTint
        self.errorText = errorText
    }
}

typealias EmailLoginInfo = (email: String, password: String)
final class LoginDataModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirm = ""
    @Published var error: Error?
    @Published var isLogin = false
    @Published var isLoading = false
    @Published var loginFieldError: NnLoginFieldError?
    
    private let colorOptions: LoginColorOptions
    private let guestLogin: (() async throws -> Void)?
    private let emailLogin: ((EmailLoginInfo) async throws -> Void)?
    private let emailSignUp: ((EmailLoginInfo) async throws -> Void)
    
    init(colorOptions: LoginColorOptions, guestLogin: (() async throws -> Void)?, emailLogin: ((EmailLoginInfo) async throws -> Void)?, emailSignUp: @escaping (EmailLoginInfo) async throws -> Void) {
        self.colorOptions = colorOptions
        self.guestLogin = guestLogin
        self.emailLogin = emailLogin
        self.emailSignUp = emailSignUp
    }
}


// MARK: - View Model
extension LoginDataModel {
    var title: String { isLogin ? "Login" : "Sign Up" }
    var accountButtonText: String { "\(isLogin ? "Don't" : "Already") have an account?" }
    var canShowAccountButton: Bool { emailLogin != nil }
    var canShowGuestLoginButton: Bool { guestLogin != nil }
    var colors: LoginColorOptions { colorOptions }
    
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
private extension LoginDataModel {
    var loginInfo: EmailLoginInfo { (email, password) }
    
    func loginOrSignUp(shouldSkip: Bool) async throws {
        if shouldSkip {
            try await guestLogin?()
        } else {
            try LoginInfoValidator.validateInfo(email: email, password: password, confirm: isLogin ? nil : confirm)
            
            if isLogin {
                try await emailLogin?(loginInfo)
            } else {
                try await emailSignUp(loginInfo)
            }
        }
    }
}


// MARK: - MainActor
private extension LoginDataModel {
    @MainActor func stopLoading() { self.isLoading = false }
    @MainActor func showError(_ error: Error?) {
        if let loginFieldError = error as? NnLoginFieldError {
            self.loginFieldError = loginFieldError
        } else {
            self.error = error
        }
    }
}
