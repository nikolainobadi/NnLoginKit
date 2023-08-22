//
//  EmailLoginView.swift
//  
//
//  Created by Nikolai Nobadi on 5/27/23.
//

import SwiftUI
import NnSwiftUIErrorHandling

struct EmailLoginView: View {
    @Binding var isEditingTextFields: Bool
    @State private var showingResetPassword = false
    @FocusState var selectedField: LoginSelectedField?
    @State private var loginInfo: LoginInfo = LoginInfo()
    @State private var loginFieldError: NnLoginFieldError?
    
    let colorsConfig: NnLoginColorsConfig
    let resetPassword: ((String) async throws -> Void)?
    let loginAction: (String, String) async throws -> Void
    
    private var canShowResetPassword: Bool {
        return resetPassword != nil
    }
    
    private var loginButtonText: String {
        return canShowResetPassword ? "Login" : "Sign Up"
    }
    
    private func tryLogin() async throws {
        selectedField = nil
        loginFieldError = nil
        
        do {
            try LoginInfoValidator.validateInfo(loginInfo, isSignUp: !canShowResetPassword)
            
            try await loginAction(loginInfo.email, loginInfo.password)
        } catch let loginFieldError as NnLoginFieldError {
            self.loginFieldError = loginFieldError
        } catch {
            throw error
        }
    }
    
    var body: some View {
        VStack {
            LoginTextField(text: $loginInfo.email, imageName: "envelope", prompt: "email...", keyboard: .emailAddress)
                .focused($selectedField, equals: .email)
                .submitLabel(.next)
                .onSubmit { selectedField = .password }
                .withBorderOverlay(loginFieldError == .email)
            
            LoginTextField(text: $loginInfo.password, imageName: "lock.fill", prompt: "password", canBeSecure: true, imageTint: colorsConfig.textFieldTint)
                .focused($selectedField, equals: .password)
                .submitLabel(.next)
                .onSubmit { selectedField = canShowResetPassword ? nil : .confirm }
                .withBorderOverlay(loginFieldError == .password)
            
            if canShowResetPassword {
                Button(action: { showingResetPassword = true }) {
                    Text("Forgot Password?")
                        .underline()
                        .setCustomFont(.caption, textColor: colorsConfig.underlinedButtonColor)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
            } else {
                LoginTextField(text: $loginInfo.confirm, imageName: "lock", prompt: "confirm password", canBeSecure: true, imageTint: colorsConfig.textFieldTint)
                    .focused($selectedField, equals: .confirm)
                    .submitLabel(.done)
                    .onSubmit { selectedField = nil }
                    .withBorderOverlay(loginFieldError == .confirm)
            }
            
            NnAsyncTryButton(action: tryLogin) {
                Text(loginButtonText)
                    .frame(maxWidth: .infinity)
                    .setCustomFont(.subheadline, textColor: colorsConfig.buttonTextColor)
            }
            .padding(.vertical)
            .buttonStyle(.borderedProminent)
            .tint(colorsConfig.buttonBackgroundColor)
        }
        .onChange(of: selectedField) { newValue in
            isEditingTextFields = newValue != nil
        }
        .sheet(isPresented: $showingResetPassword) {
            if let resetPassword = resetPassword {
                ResetPasswordView(colorsConfig: colorsConfig, sendResetEmail: resetPassword)
            }
        }
    }
}


// MARK: - Preview
struct EmailLoginView_Previews: PreviewProvider {
    static var previews: some View {
//        EmailLoginView(colorsConfig: NnLoginColorsConfig(), resetPassword: nil)
        EmailLoginView(isEditingTextFields: .constant(false), colorsConfig: NnLoginColorsConfig(), resetPassword: { _ in }, loginAction: { (_, _) in })
            .withNnLoadingView()
            .withNnErrorHandling()
    }
}
