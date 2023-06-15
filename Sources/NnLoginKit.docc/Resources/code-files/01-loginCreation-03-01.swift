//
//  LoginComposer.swift
//

import SwiftUI
import NnLoginKit

enum LoginComposer {
    static func composeLoginView() -> some View {
        
    }
}

private extension LoginComposer {
    static func composeTextConfig() -> NnLoginTextConfig {
        // Customize the text configuration based on your needs
        let appTitle = "Your App"
        let tagline = "A tagline for your app"
        let subTagline = "A sub tagline for your app"
        
        return NnLoginTextConfig(appTitle: appTitle, tagline: tagline, subTagline: subTagline)
    }
    
    static func composeColorsConfig() -> NnLoginColorsConfig {
        return NnLoginColorsConfig(titleColor: .blue,
                                   detailsColor: .secondary,
                                   buttonTextColor: .white,
                                   buttonBackgroundColor: .blue,
                                   underlinedButtonColor: .blue,
                                   viewBackgroundColor: .color(.blue),
                                   textFieldTint: .blue,
                                   errorTextColor: .red)
    }
}
