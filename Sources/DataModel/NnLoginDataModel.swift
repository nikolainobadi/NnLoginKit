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
