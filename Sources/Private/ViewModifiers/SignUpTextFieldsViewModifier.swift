//
//  SignUpTextFieldsViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 6/6/23.
//

import SwiftUI

internal struct SignUpTextFieldsViewModifier: ViewModifier {
    @Binding var isShowing: Bool
    @Binding var email: String
    @Binding var password: String
    @Binding var confirm: String
    
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .alert("", isPresented: $isShowing, actions: {
                TextField("email", text: $email)
                SecureField("password", text: $password)
                SecureField("confirm password", text: $confirm)
                NoLoadingAsyncTryButton(action: action, role: .destructive) {
                    Text("Sign up")
                }
            }, message: {
                Text("Here is a message")
            })
    }
}

internal extension View {
    func withSignUpTextFieldsAlert(isShowing: Binding<Bool>, email: Binding<String>, password: Binding<String>, confirm: Binding<String>, action: @escaping () async throws -> Void) -> some View {
        modifier(SignUpTextFieldsViewModifier(isShowing: isShowing, email: email, password: password, confirm: confirm, action: action))
    }
}

