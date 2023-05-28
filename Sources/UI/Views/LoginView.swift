//
//  LoginView.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI

struct LoginView<ResetView: View>: View {
    @StateObject var dataModel: LoginDataModel
    @State private var showingResetPassword = false
    @FocusState private var selectedField: LoginSelectedField?
    
    let resetView: ResetView
    let canShowResetView: Bool
    
    private var isLogin: Bool { dataModel.isLogin }
    private var fieldError: NnLoginFieldError? { dataModel.loginFieldError }
    private var showGuestLogin: Bool { dataModel.canShowGuestLoginButton }
    private var showAccountButton: Bool { dataModel.canShowAccountButton }
    private var colors: LoginColorOptions { dataModel.colors }
    
    private func login() { dataModel.login() }
    private func guestLogin() { dataModel.login(shouldSkip: true) }
    private func toggleLoginType() { dataModel.isLogin.toggle() }
    
    var body: some View {
        VStack {
            Text(dataModel.title)
//                .setLoginFont(.largeTitle, textColor: colors.title, autoSize: true)
            
            Spacer()
            
            LoginFields(showingResetPassword: $showingResetPassword, selectedField: _selectedField, dataModel: dataModel, canShowReset: canShowResetView)
                .padding()
                
            Button(action: login) {
                Text(dataModel.title)
//                    .setLoginFont(.headline, textColor: colors.buttonText)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(colors.buttonBackground)
            .padding()
            
            if showAccountButton {
                Button(action: toggleLoginType) {
                    Text(dataModel.accountButtonText)
                        .underline()
//                        .setLoginFont(.body, textColor: colors.underlinedButtons)
                }
            }
            
            Spacer()
            
            if showGuestLogin {
                Button(action: guestLogin) {
                    Text("Login as Guest")
                        .underline()
//                        .setLoginFont(.caption, textColor: colors.underlinedButtons)
                }
            }
        }
        .background(colors.viewBackground)
        .sheet(isPresented: $showingResetPassword, content: { resetView })
    }
}


fileprivate struct LoginFields: View {
// MARK: - LoginFields
    @Binding var showingResetPassword: Bool
    @FocusState var selectedField: LoginSelectedField?
    @ObservedObject var dataModel: LoginDataModel
    
    let canShowReset: Bool
    
    private var isLogin: Bool { dataModel.isLogin }
    private var fieldError: NnLoginFieldError? { dataModel.loginFieldError }
    
    private func login() { selectedField = nil; dataModel.login() }
    private func guestLogin() { selectedField = nil; dataModel.login(shouldSkip: true) }
    
    var body: some View {
        VStack {
            Text(fieldError?.message ?? "")
                .lineLimit(1)
                .foregroundColor(.red)
//                .setLoginFont(.body, isSmooth: true, autoSize: true)
                .opacity(fieldError == nil ? 0 : 1)
                .padding(.horizontal)

            LoginTextField(text: $dataModel.email, imageName: "envelope", prompt: "email...", keyboard: .emailAddress)
                .focused($selectedField, equals: .email)
                .submitLabel(.next)
                .onSubmit { selectedField = .password }
                .withBorderOverlay(fieldError == .email)

            LoginTextField(text: $dataModel.password, imageName: "lock", prompt: "password", canBeSecure: true ,imageTint: dataModel.colors.textFieldTint)
                .focused($selectedField, equals: .password)
                .submitLabel(.next)
                .onSubmit { isLogin ? selectedField = .confirm : login() }
                .withBorderOverlay(fieldError == .password)

            if isLogin {
                if canShowReset {
                    Button(action: { showingResetPassword = true }) {
                        Text("Forgot Password?")
                            .underline()
//                            .setLoginFont(.body, textColor: dataModel.colors.underlinedButtons)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                }
                
            } else {
                LoginTextField(text: $dataModel.confirm, imageName: "lock.fill", prompt: "confirm password", canBeSecure: true ,imageTint: dataModel.colors.textFieldTint)
                    .focused($selectedField, equals: .confirm)
                    .submitLabel(.done)
                    .onSubmit { login() }
                    .withBorderOverlay(fieldError == .confirm)
            }
        }
    }
}

// MARK: - Preview
struct NnLoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(dataModel: makeDataModel(), resetView: Text("ResetPassword View"), canShowResetView: true)
    }
}


// MARK: - Preview Helpers
private extension NnLoginView_Previews {
    static func makeDataModel(colorOptions: LoginColorOptions = LoginColorOptions(), enableGuestLogin: Bool = false, enableLogin: Bool = false) -> LoginDataModel {
        LoginDataModel(colorOptions: colorOptions, guestLogin: enableGuestLogin ? { } : nil, emailLogin: enableLogin ? { _ in } : nil, emailSignUp: { _ in })
    }
}
