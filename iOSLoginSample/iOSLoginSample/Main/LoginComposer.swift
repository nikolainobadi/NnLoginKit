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
    case subtle
    case deepEnd
    case darkBlue
    
    var color: Color {
        switch self {
        case .lightStart:
            return Color(red: 0.882, green: 0.961, blue: 0.996)
        case .subtle:
            return Color(red: 0.702, green: 0.898, blue: 0.988)
        case .deepEnd:
            return Color(red: 0.161, green: 0.710, blue: 0.965)
        case .darkBlue:
            return Color(red: 0.082, green: 0.396, blue: 0.753)
        }
    }

    var gradient: LinearGradient {
        switch self {
        case .lightStart:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 0.207, green: 0.525, blue: 0.647), Color(red: 0.882, green: 0.961, blue: 0.996), Color(red: 0.207, green: 0.525, blue: 0.647)]), startPoint: .top, endPoint: .bottom)
        case .subtle:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 0.615, green: 0.866, blue: 0.922), Color(red: 0.702, green: 0.898, blue: 0.988), Color(red: 0.615, green: 0.866, blue: 0.922)]), startPoint: .top, endPoint: .bottom)
        case .deepEnd, .darkBlue:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 0.053, green: 0.427, blue: 0.482), Color(red: 0.161, green: 0.710, blue: 0.965), Color(red: 0.053, green: 0.427, blue: 0.482)]), startPoint: .top, endPoint: .bottom)
        }
    }
}
