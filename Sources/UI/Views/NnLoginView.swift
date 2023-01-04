//
//  NnLoginView.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI
import NnSwiftUIDesignHelpers

enum LoginSelectedField {
    case email, password, confirm
}

struct NnLoginView: View {
    @StateObject var dataModel: NnLoginDataModel
    @State private var showingResetPassword = false
    @FocusState private var selectedField: LoginSelectedField?
    
    private var isLogin: Bool { dataModel.isLogin }
    private var fieldError: NnLoginFieldError? { dataModel.loginFieldError }
    
    private func login() { selectedField = nil; dataModel.login() }
    private func guestLogin() { selectedField = nil; dataModel.login(shouldSkip: true) }
    private func toggleIsLogin() { selectedField = nil; dataModel.isLogin.toggle() }
    
    var body: some View {
        VStack {
            Text(dataModel.title)
                .setLoginFont(.largeTitle, textColor: dataModel.viewColors.title, autoSize: true)
            
            Spacer()
            
            LoginFields(showingResetPassword: $showingResetPassword, selectedField: _selectedField, dataModel: dataModel)
                .padding()
            
            Button(action: login) {
                Text(dataModel.title)
                    .setLoginFont(.headline, textColor: dataModel.viewColors.loginButtonText)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button(action: toggleIsLogin) {
                Text(dataModel.accountButtonText)
                    .underline()
                    .setLoginFont(.body, textColor: dataModel.viewColors.underlinedButtons)
            }
            
            Spacer()
            
            if dataModel.canShowGuestLogin {
                Button(action: guestLogin) {
                    Text("Login as Guest")
                        .underline()
                }
            }
        }
        .background(dataModel.viewColors.backgroundColor)
        .withErrorHandling(error: $dataModel.error, doneAction: { dataModel.error = nil })
    }
}


// MARK: - LoginFields
fileprivate struct LoginFields: View {
    @Binding var showingResetPassword: Bool
    @FocusState var selectedField: LoginSelectedField?
    @ObservedObject var dataModel: NnLoginDataModel
    
    private var isLogin: Bool { dataModel.isLogin }
    private var fieldError: NnLoginFieldError? { dataModel.loginFieldError }
    
    private func login() { selectedField = nil; dataModel.login() }
    private func guestLogin() { selectedField = nil; dataModel.login(shouldSkip: true) }
    
    var body: some View {
        VStack {
            Text(fieldError?.message ?? "")
                .lineLimit(1)
                .foregroundColor(.red)
                .opacity(fieldError == nil ? 0 : 1)
                .padding(.horizontal)
                .minimumScaleFactor(0.5)

            LoginTextField(text: $dataModel.email, imageName: "envelope", prompt: "email...", keyboard: .emailAddress)
                .focused($selectedField, equals: .email)
                .submitLabel(.next)
                .onSubmit { selectedField = .password }
                .withConditionalRedOverlay(dataModel.loginFieldError == .email)

            LoginTextField(text: $dataModel.password, imageName: "lock", prompt: "password", canBeSecure: true, imageTint: dataModel.viewColors.textFieldTint)
                .focused($selectedField, equals: .password)
                .submitLabel(.next)
                .onSubmit { isLogin ? selectedField = .confirm : login() }
                .withConditionalRedOverlay(fieldError == .password)

            if isLogin {
                Button(action: { showingResetPassword = true }) {
                    Text("Forgot Password?")
                        .underline()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
            } else {
                LoginTextField(text: $dataModel.confirm, imageName: "lock.fill", prompt: "confirm password", canBeSecure: true, imageTint: dataModel.viewColors.textFieldTint)
                    .focused($selectedField, equals: .confirm)
                    .submitLabel(.done)
                    .onSubmit { login() }
                    .withConditionalRedOverlay(fieldError == .confirm)
            }
        }
    }
}


// MARK: - TextField
struct LoginTextField: View {
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
        NnLoginView(dataModel: dataModel)
    }
}


// MARK: - Preview Helpers
private extension NnLoginView_Previews {
    static var dataModel: NnLoginDataModel { NnLoginDataModel(actions: MockActions()) }
    
    class MockActions: NnLoginActions {
        func guestLogin() async throws { }
        func login(email: String, password: String) async throws { }
        func signUp(email: String, password: String) async throws { }
    }
}
