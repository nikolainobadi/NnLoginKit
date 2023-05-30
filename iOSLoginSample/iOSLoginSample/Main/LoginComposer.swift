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
        
        return NnLoginKit.makeLoginView(titleImage: nil, canShowResetPassword: true, loginColors: makeLoginColors(), auth: auth)
    }
}

private extension LoginComposer {
    static func makeLoginColors() -> LoginViewColors {
        LoginViewColors(appTitleColor: MyColor.darkBlue.color, tagLineColor: MyColor.darkBlue.color, getStartedButtonColor: MyColor.darkBlue.color, accountButtonColor: MyColor.darkBlue.color, emailLoginColors: makeEmailLoginColors())
    }
    
    static func makeEmailLoginColors() -> EmailLoginColors {
        EmailLoginColors(eyeImageColor: MyColor.darkBlue.color, forgotPasswordButtonColor: MyColor.darkBlue.color, loginButtonBackgroundColor: MyColor.darkBlue.color)
    }
}

import SwiftUI

enum MyColor {
    case lightStart
    case deepEnd
    case darkBlue
    
    var color: Color {
        switch self {
        case .lightStart:
            return Color(red: 0.882, green: 0.961, blue: 0.996)
        case .deepEnd:
            return Color(red: 0.161, green: 0.710, blue: 0.965)
        case .darkBlue:
            return Color(red: 0.082, green: 0.396, blue: 0.753)
        }
    }

    var gradient: LinearGradient {
        switch self {
        case .lightStart:
            return LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.blue.opacity(0.6), Color.blue.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
        case .deepEnd:
            return LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.8), Color.blue.opacity(1.0)]), startPoint: .top, endPoint: .bottom)
        case .darkBlue:
            return LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue.opacity(0.8), Color.blue.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
        }
    }
}
