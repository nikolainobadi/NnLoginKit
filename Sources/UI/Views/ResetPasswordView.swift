//
//  ResetPasswordView.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI
import NnSwiftUIDesignHelpers

struct ResetPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var dataModel: ResetPasswordDataModel
    
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
struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(dataModel: dataModel)
    }
}


// MARK: - Preview Helpers
extension ResetPasswordView_Previews {
    static var dataModel: ResetPasswordDataModel { ResetPasswordDataModel() }
}
