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
    
    var body: some View {
        VStack {
            if let errorMessage = dataModel.loginErrorMessage {
                Text(errorMessage)
                    .bold()
                    .foregroundColor(.red)
            }
            
            LoginTextField(text: $dataModel.email, imageName: "envelope", prompt: "email...", keyboard: .emailAddress)
                .focused($selectedField, equals: .email)
                .submitLabel(.next)
                .onSubmit { selectedField = .password }
                .withBorderOverlay(dataModel.loginFieldError == .email)
            
            LoginTextField(text: $dataModel.password, imageName: "lock.fill", prompt: "password", canBeSecure: true)
                .focused($selectedField, equals: .password)
                .submitLabel(.next)
                .onSubmit { selectedField = dataModel.canShowResetPassword ? nil : .confirm }
                .withBorderOverlay(dataModel.loginFieldError == .password)
            
            if dataModel.canShowResetPassword {
                Button(action: { showingResetPassword = true }) {
                    Text("Forgot Password?")
                        .underline()
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
            } else {
                LoginTextField(text: $dataModel.confirm, imageName: "lock", prompt: "confirm password", canBeSecure: true)
                    .focused($selectedField, equals: .confirm)
                    .submitLabel(.done)
                    .onSubmit { selectedField = nil }
                    .withBorderOverlay(dataModel.loginFieldError == .confirm)
            }
            
            Button {
                selectedField = nil
                dataModel.tryLogin()
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical)
            .buttonStyle(.borderedProminent)
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
    init(isEditingTextFields: Binding<Bool>? = nil, dataModel: EmailLoginDataModel) {
        _isEditingTextFields = isEditingTextFields ?? .constant(false)
        self.dataModel = dataModel
    }
}


// MARK: - Preview
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        EmailLoginView(dataModel: dataModel)
    }
    
    static var dataModel: EmailLoginDataModel {
        EmailLoginDataModel(canShowResetPassword: true, emailLogin: { _, _ in })
    }
}
