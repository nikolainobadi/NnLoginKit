//
//  LoginView.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI
import NnSwiftUIDesignHelpers

enum LoginSelectedField {
    case email, password, confirm
}

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
                .setLoginFont(.largeTitle, textColor: colors.title, autoSize: true)
            
            Spacer()
            
            LoginFields(showingResetPassword: $showingResetPassword, selectedField: _selectedField, dataModel: dataModel, canShowReset: canShowResetView)
                .padding()
                
            Button(action: login) {
                Text(dataModel.title)
                    .setLoginFont(.headline, textColor: colors.buttonText)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(colors.buttonBackground)
            .padding()
            
            if showAccountButton {
                Button(action: toggleLoginType) {
                    Text(dataModel.accountButtonText)
                        .underline()
                        .setLoginFont(.body, textColor: colors.underlinedButtons)
                }
            }
            
            Spacer()
            
            if showGuestLogin {
                Button(action: guestLogin) {
                    Text("Login as Guest")
                        .underline()
                        .setLoginFont(.caption, textColor: colors.underlinedButtons)
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
                .setLoginFont(.body, isSmooth: true, autoSize: true)
                .opacity(fieldError == nil ? 0 : 1)
                .padding(.horizontal)

            LoginTextField(text: $dataModel.email, imageName: "envelope", prompt: "email...", keyboard: .emailAddress)
                .focused($selectedField, equals: .email)
                .submitLabel(.next)
                .onSubmit { selectedField = .password }
                .withConditionalRedOverlay(dataModel.loginFieldError == .email)

            LoginTextField(text: $dataModel.password, imageName: "lock", prompt: "password", canBeSecure: true ,imageTint: dataModel.colors.textFieldTint)
                .focused($selectedField, equals: .password)
                .submitLabel(.next)
                .onSubmit { isLogin ? selectedField = .confirm : login() }
                .withConditionalRedOverlay(fieldError == .password)

            if isLogin {
                if canShowReset {
                    Button(action: { showingResetPassword = true }) {
                        Text("Forgot Password?")
                            .underline()
                            .setLoginFont(.body, textColor: dataModel.colors.underlinedButtons)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                }
                
            } else {
                LoginTextField(text: $dataModel.confirm, imageName: "lock.fill", prompt: "confirm password", canBeSecure: true ,imageTint: dataModel.colors.textFieldTint)
                    .focused($selectedField, equals: .confirm)
                    .submitLabel(.done)
                    .onSubmit { login() }
                    .withConditionalRedOverlay(fieldError == .confirm)
            }
        }
    }
}


// MARK: - TextField
fileprivate struct LoginTextField: View {
    @Binding var text: String
    @State private var isSecured: Bool
    
    let imageName: String
    let prompt: String
    let canBeSecure: Bool
    let keyboard: UIKeyboardType
    let imageTint: Color
    
    private var eyeImage: String { isSecured ? "eye.slash" : "eye" }
    
    init(text: Binding<String>, imageName: String, prompt: String, canBeSecure: Bool = false, keyboard: UIKeyboardType = .asciiCapable, imageTint: Color = .blue) {
        self._text = text
        self.imageName = imageName
        self.prompt = prompt
        self.canBeSecure = canBeSecure
        self.isSecured = canBeSecure
        self.keyboard = keyboard
        self.imageTint = imageTint
    }
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            
            if isSecured {
                SecureField("", text: $text, prompt: Text(prompt))
                    .font(.title2)
                    .keyboardType(keyboard)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            } else {
                TextField("", text: $text, prompt: Text(prompt))
                    .font(.title2)
                    .keyboardType(keyboard)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            }
            
            if canBeSecure {
                Button(action: { isSecured.toggle() }) {
                    Image(systemName: eyeImage)
                        .tint(imageTint)
                }
            }
        }.withRoundedBorder()
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
