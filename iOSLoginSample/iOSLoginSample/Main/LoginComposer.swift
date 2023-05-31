//
//  LoginComposer.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI
import NnLoginKit

enum LoginComposer {
    static func makeLoginView(store: UserIdStore) -> some View {
        let auth = LoginNetworker(store: store)
        let textConfig = makeTextConfig()
        let colorsConfig = makeColorsConfig()
        
        return NnLoginKit.makeLoginView(titleImage: Image(systemName: "house"), textConfig: textConfig, colorsConfig: colorsConfig, auth: auth)
    }
}

private extension LoginComposer {
    static func makeTextConfig() -> LoginTextConfig {
        LoginTextConfig(appTitle: "NnLoginKit Demo", tagline: "This is a tagline", subTagline: "This is where more words can go in case the tagline is not enough")
    }
    static func makeColorsConfig() -> LoginColorsConfig {
        return LoginColorsConfig(titleColor: .blue,
                                 buttonTextColor: .white,
                                 buttonBackgroundColor: .blue,
                                 underlinedButtonColor: .blue,
                                 viewBackgroundColor: .gradient(MyGradient.smoothBlue.gradient()),
                                 textFieldTint: .blue,
                                 errorTextColor: .red)
    }
}

enum MyGradient {
    case lightBlue
    case coolBlue
    case vibrantBlue
    case smoothBlue
    
    func gradient() -> LinearGradient {
        switch self {
        case .lightBlue:
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.7, green: 0.85, blue: 1.0),
                    Color(red: 0.75, green: 0.9, blue: 1.0),
                    Color(red: 0.8, green: 0.95, blue: 1.0),
                    Color(red: 0.85, green: 1.0, blue: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .coolBlue:
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.2, green: 0.6, blue: 0.8),
                    Color(red: 0.3, green: 0.7, blue: 0.9),
                    Color(red: 0.4, green: 0.8, blue: 1.0),
                    Color(red: 0.5, green: 0.9, blue: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .vibrantBlue:
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.0, green: 0.3, blue: 0.6),
                    Color(red: 0.1, green: 0.4, blue: 0.7),
                    Color(red: 0.2, green: 0.5, blue: 0.8),
                    Color(red: 0.3, green: 0.6, blue: 0.9)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .smoothBlue:
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.6, green: 0.75, blue: 0.9),
                    Color(red: 0.65, green: 0.8, blue: 0.95),
                    Color(red: 0.7, green: 0.85, blue: 1.0),
                    Color(red: 0.75, green: 0.9, blue: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}
