//
//  ResetPasswordView.swift
//  
//
//  Created by Nikolai Nobadi on 5/30/23.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var email = ""
    @State private var emailSentSuccess = false
    @Environment(\.dismiss) private var dismiss
    
    let colorsConfig: LoginColorsConfig
    let sendResetEmail: (String) async throws -> Void
    
    private var message: String {
        if emailSentSuccess {
            return "An email was sent to \(email) that should allow you to reset your password."
        } else {
            return "Enter your email address and a link will be sent allowing you to reset your password."
        }
    }
    
    private func sendEmail() async throws {
        try await sendResetEmail(email)
        self.emailSentSuccess = true
    }
    
    var body: some View {
        VStack(spacing: getHeightPercent(10)) {
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .font(.title)
                                .foregroundColor(colorsConfig.buttonBackgroundColor)
                        }
                    }
                    .padding([.horizontal, .top])
                    
                    Text("Reset Password")
                        .lineLimit(1)
                        .setCustomFont(.largeTitle, textColor: colorsConfig.titleColor, autoSize: true)
                        .padding([.horizontal])
                }
                
                Text(message)
                    .multilineTextAlignment(.center)
                    .setCustomFont(.body, isSmooth: true, textColor: colorsConfig.detailsColor)
                    .padding()
            }
            
            if emailSentSuccess {
                Button(action: { dismiss() }) {
                    Text("Okay")
                        .setCustomFont(.subheadline, textColor: colorsConfig.buttonTextColor)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(colorsConfig.buttonBackgroundColor)
                .padding()
                
            } else {
                VStack(spacing: getHeightPercent(3)) {
                    LoginTextField(text: $email, imageName: "envelope", prompt: "email")
                    
                    AsyncTryButton(action: sendEmail) {
                        Text("Send Reset Email")
                            .setCustomFont(.subheadline, textColor: colorsConfig.buttonTextColor)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(colorsConfig.buttonBackgroundColor)
                }
                .padding()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(colorsConfig.viewBackgroundColor.view())
    }
}


// MARK: - Preview
struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(colorsConfig: LoginColorsConfig(), sendResetEmail: { _ in })
    }
}
