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
    
    public init(actions: NnLoginActions, config: NnLoginViewConfig) {
        self.actions = actions
        self.config = config
    }
}

public extension NnLoginDataModel {
    var title: String { isLogin ? "Login" : "Sign Up" }
    var accountButtonText: String { "\(isLogin ? "Don't" : "Already") have an account?" }
    var canShowGuestLogin: Bool { options.enableGuestLogin }
    var canShowResetPassword: Bool { options.enableResetPassword }
    var canShowAccountButton: Bool { options.enableToggleLoginType }
    
    func login() {
        
    }
    
    func guestLogin() {
        
    }
}

private extension NnLoginDataModel {
    var options: NnLoginViewConfig.LoginOptions { config.options }
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
    
    public init(colors: ColorOptions, options: LoginOptions) {
        self.colors = colors
        self.options = options
    }
}

public extension NnLoginViewConfig {
    struct ColorOptions {
        var title: Color? = .primary
        var underlinedButtons: Color? = nil
        var loginButtonBackground: Color? = nil
        var loginButtonText: Color? = nil
        var textFieldTint: Color? = nil
        var errorText: Color = .red
    }
    
    struct LoginOptions {
        var enableGuestLogin: Bool = false
        var enableResetPassword: Bool = true
        var enableToggleLoginType: Bool = true
    }
}

