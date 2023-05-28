//
//  ResetPasswordView.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI

struct ResetPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var dataModel: ResetPasswordDataModel
    
    private var colors: LoginColorOptions { dataModel.colors }
    
    var body: some View {
        VStack(spacing: getHeightPercent(10)) {
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
//                            .setLoginFont(.body)
                    }.padding()
                    Spacer()
                }
                
                Text("Reset Password")
//                    .setLoginFont(.title, textColor: colors.title, autoSize: true)
            }.padding()
            
            VStack(spacing: getHeightPercent(5)) {
                Text(dataModel.message)
                    .multilineTextAlignment(.center)
//                    .setLoginFont(.body, isSmooth: true, textColor: colors.detailsText)
                    .padding()
                
                VStack(spacing: getHeightPercent(5)) {
                    TextField("", text: $dataModel.email, prompt: Text("email..."))
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
//                        .withRoundedBorder()
                        
                    Button(action: dataModel.resetPassword) {
                        Text("Reset Password")
//                            .setLoginFont(.subheadline, textColor: colors.buttonText)
                            .frame(maxWidth: getWidthPercent(70))
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(colors.buttonBackground)
                    .disabled(dataModel.disableButton)
                    .opacity(dataModel.disableButton ? 0.5 : 1)
                }.padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(colors.viewBackground)
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
    static var dataModel: ResetPasswordDataModel {
        ResetPasswordDataModel(colorOptions: LoginColorOptions(), sendResetPassswordEmail: { _ in })
    }
}
