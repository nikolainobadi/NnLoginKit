//
//  NnLoginViewConfig.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI
import Foundation

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
