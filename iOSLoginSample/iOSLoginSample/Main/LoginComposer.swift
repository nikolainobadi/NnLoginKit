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
        let colorOptions = makeColorOptions()
        let networker = LoginNetworker(store: SharedUserIdStorage.shared)
        
        return NnLoginKit.makeLoginView(colorOptions: colorOptions,
                                        guestLogin: networker.guestLogin,
                                        emailLogin: networker.emailLogin(_:),
                                        emailSignUp: networker.emailSignUp(_:))
    }
    
    private static func makeColorOptions() -> LoginColorOptions {
        LoginColorOptions(title: .blue,
                          buttonText: .white,
                          buttonBackground: .blue,
                          underlinedButtons: .blue,
                          viewBackground: Color(uiColor: .secondarySystemBackground),
                          textFieldTint: .blue)
    }
}
