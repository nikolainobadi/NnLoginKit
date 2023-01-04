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
    
    private func login() { dataModel.login() }
    private func guestLogin() { dataModel.login(shouldSkip: true) }
    private func toggleIsLogin() { dataModel.isLogin.toggle() }
    
    var body: some View {
        VStack {
            Text(dataModel.title)
            
            Spacer()
            
            VStack {
                Text("errorMessage")
                    .lineLimit(1)
                    .foregroundColor(.red)
                    .opacity(dataModel.loginFieldError == nil ? 0 : 1)
                    .padding(.horizontal)
                    .minimumScaleFactor(0.5)
                
                LoginTextField(text: $dataModel.email, imageName: "envelope", prompt: "email...")
                    .focused($selectedField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { selectedField = .password }
                    .withConditionalRedOverlay(fieldError == .email)
                
                LoginTextField(text: $dataModel.password, imageName: "lock.fill", prompt: "password", canBeSecure: true)
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
                    LoginTextField(text: $dataModel.confirm, imageName: "lock", prompt: "confirm password", canBeSecure: true)
                        .focused($selectedField, equals: .confirm)
                        .submitLabel(.done)
                        .onSubmit { login() }
                        .withConditionalRedOverlay(fieldError == .confirm)
                }
            }.padding()
            
            Button(action: login) {
                Text(dataModel.title)
            }.buttonStyle(.borderedProminent)
            
            Button(action: toggleIsLogin) {
                Text(dataModel.accountButtonText)
                    .underline()
            }
            
            Spacer()
            
            if dataModel.canShowGuestLogin {
                Button(action: guestLogin) {
                    Text("Login as Guest")
                        .underline()
                }
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
    
    private var eyeImage: String { isSecured ? "eye.slash" : "eye" }
    
    init(text: Binding<String>, imageName: String, prompt: String, canBeSecure: Bool = false, keyboard: UIKeyboardType = .asciiCapable) {
        self._text = text
        self.imageName = imageName
        self.prompt = prompt
        self.canBeSecure = canBeSecure
        self.isSecured = canBeSecure
        self.keyboard = keyboard
    }
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            
            if isSecured {
                SecureField("", text: $text, prompt: Text(prompt))
                    .font(.title2)
                    .keyboardType(keyboard)
            } else {
                TextField("", text: $text, prompt: Text(prompt))
                    .font(.title2)
                    .keyboardType(keyboard)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            
            if canBeSecure {
                Button(action: { isSecured.toggle() }) {
                    Image(systemName: eyeImage)
                        .tint(.green)
                }
            }
        }
        .padding(5)
        .accentColor(.primary)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(10)
        .shadow(color: .primary, radius: 3)
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
