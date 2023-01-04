//
//  NnResetPasswordView.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI
import NnSwiftUIDesignHelpers

struct NnResetPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var dataModel: NnResetPasswordDataModel
    
    var body: some View {
        VStack {
            Text("Reset Password")
                .setLoginFont(.title, autoSize: true)
                .padding()
            Text(dataModel.message)
                .setLoginFont(.body, isSmooth: true)
                .padding()
            
            VStack(spacing: getHeightPercent(5)) {
                TextField("", text: $dataModel.email, prompt: Text("email..."))
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .withRoundedBorder()
                    
                Button(action: dataModel.resetPassword) {
                    Text("Reset Password")
                        .setLoginFont(.subheadline)
                }
                .disabled(dataModel.disableButton)
                .opacity(dataModel.disableButton ? 0.5 : 1)
                .withRoundedBorder()
            }.padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//            .background(Color.viewBackroundColor.ignoresSafeArea())
        .navigationTitle("Reset Password")
        .navigationBarTitleDisplayMode(.inline)
        .withErrorHandling(error: $dataModel.error)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Text("Cancel")
                        .setLoginFont(.body)
                }
            }
        }
    }
}


// MARK: - Preview
struct NnResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NnResetPasswordView(dataModel: dataModel)
    }
}


// MARK: - Preview Helpers
extension NnResetPasswordView_Previews {
    static var dataModel: NnResetPasswordDataModel { NnResetPasswordDataModel(actions: MockActions()) }
    
    class MockActions: NnResetPasswordActions {
        func sendResetPasswordEmail(email: String) async throws { }
    }
}

final class NnResetPasswordDataModel: ObservableObject {
    @Published var email = ""
    @Published var error: Error?
    
    private let actions: NnResetPasswordActions
    
    init(actions: NnResetPasswordActions) {
        self.actions = actions
    }
}

extension NnResetPasswordDataModel {
    var disableButton: Bool { email.count < 6 || !email.contains("@") || !email.contains(".") }
    var message: String { "Enter your email address and a link will be sent allowing you to reset your password." }
    
    func resetPassword() { }
}


// MARK: - Dependencies
protocol NnResetPasswordActions {
    func sendResetPasswordEmail(email: String) async throws
}
