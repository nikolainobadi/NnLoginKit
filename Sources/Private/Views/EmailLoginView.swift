//
//  EmailLoginView.swift
//  
//
//  Created by Nikolai Nobadi on 5/27/23.
//

import SwiftUI

struct EmailLoginView: View {
    @Binding var isEditingTextFields: Bool
    @State var dataModel: EmailLoginDataModel
    @State private var showingResetPassword = false
    @FocusState var selectedField: LoginSelectedField?
    
    let colorsConfig: NnLoginColorsConfig
    
    private func tryLogin() async throws {
        selectedField = nil
        try await dataModel.tryLogin()
    }
    
    var body: some View {
        VStack {
            if let errorMessage = dataModel.loginErrorMessage {
                Text(errorMessage)
                    .bold()
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            
            LoginTextField(text: $dataModel.email, imageName: "envelope", prompt: "email...", keyboard: .emailAddress)
                .focused($selectedField, equals: .email)
                .submitLabel(.next)
                .onSubmit { selectedField = .password }
                .withBorderOverlay(dataModel.loginFieldError == .email)
            
            LoginTextField(text: $dataModel.password, imageName: "lock.fill", prompt: "password", canBeSecure: true, imageTint: colorsConfig.textFieldTint)
                .focused($selectedField, equals: .password)
                .submitLabel(.next)
                .onSubmit { selectedField = dataModel.canShowResetPassword ? nil : .confirm }
                .withBorderOverlay(dataModel.loginFieldError == .password)
            
            if dataModel.canShowResetPassword {
                Button(action: { showingResetPassword = true }) {
                    Text("Forgot Password?")
                        .underline()
                        .setCustomFont(.caption, textColor: colorsConfig.underlinedButtonColor)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
            } else {
                LoginTextField(text: $dataModel.confirm, imageName: "lock", prompt: "confirm password", canBeSecure: true, imageTint: colorsConfig.textFieldTint)
                    .focused($selectedField, equals: .confirm)
                    .submitLabel(.done)
                    .onSubmit { selectedField = nil }
                    .withBorderOverlay(dataModel.loginFieldError == .confirm)
            }
            
            AsyncTryButton(action: tryLogin) {
                Text("Login")
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
            if let sendResetEmail = dataModel.sendResetEmail {
                ResetPasswordView(colorsConfig: colorsConfig, sendResetEmail: sendResetEmail)
            }
        }
    }
}




// MARK: - Init
extension EmailLoginView {
    /// Initializes an EmailLoginView.
    ///
    /// - Parameters:
    ///   - isEditingTextFields: A binding that indicates whether the text fields are being edited.
    ///                          Defaults to `false` if not provided.
    ///   - dataModel: The data model for the login view.
    init(isEditingTextFields: Binding<Bool>? = nil, dataModel: EmailLoginDataModel, colorsConfig: NnLoginColorsConfig = NnLoginColorsConfig()) {
        _isEditingTextFields = isEditingTextFields ?? .constant(false)
        self.dataModel = dataModel
        self.colorsConfig = colorsConfig
    }
}


// MARK: - Preview
struct EmailLoginView_Previews: PreviewProvider {
    static var previews: some View {
        EmailLoginView(dataModel: dataModel)
            .withLoadingView()
            .withErrorHandling()
    }
    
    static var dataModel: EmailLoginDataModel {
        EmailLoginDataModel(sendResetEmail: { _ in }, emailLogin: { _, _ in })
    }
}
