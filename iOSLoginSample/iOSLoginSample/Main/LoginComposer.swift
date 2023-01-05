//
//  LoginComposer.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI
import NnLoginKit

enum LoginComposer {
    static func makeLoginView() -> some View {
        let networker = LoginNetworker(store: SharedUserIdStorage.shared)
        
        return makeLoginView(networker: networker)
    }
}


// MARK: - Private Methods
private extension LoginComposer {
    /// toggle each paramter to remove the associated feature within the composed LoginView (Ex. withGuestLogin: false will hide guest login button)
    static func makeLoginView(networker: LoginNetworker, withGuestLogin: Bool = true, withEmailLogin: Bool = true, withResetPassword: Bool = true) -> some View {
        NnLoginKit.makeLoginView(colorOptions: makeColorOptions(),
                                 guestLogin: withGuestLogin ? networker.guestLogin : nil,
                                 emailLogin: withEmailLogin ? networker.emailLogin(_:) : nil,
                                 emailSignUp: networker.emailSignUp(_:),
                                 resetPassword: withResetPassword ? networker.resetPassword : nil)
    }
    
    static func makeColorOptions() -> LoginColorOptions {
        LoginColorOptions(title: .blue,
                          buttonText: .white,
                          buttonBackground: .blue,
                          underlinedButtons: .blue,
                          viewBackground: Color(uiColor: .secondarySystemBackground),
                          textFieldTint: .blue)
    }
}
