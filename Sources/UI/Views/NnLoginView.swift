//
//  NnLoginView.swift
//  
//
//  Created by Nikolai Nobadi on 5/29/23.
//

import SwiftUI

struct NnLoginView: View {
    @StateObject var dataModel: NnLoginDataModel
    @State private var showingLoginOptions = false
    @State private var isEditingTextFields = false
    
    let titleImage: Image?
    let canShowResetPassword: Bool
    let loginColors: LoginViewColors
    
    var body: some View {
        VStack {
            Text(dataModel.appTitle)
                .setCustomFont(.largeTitle, textColor: loginColors.appTitleColor, autoSize: true)
                .padding(.top)
            
            if showingLoginOptions {
                VStack {
                    let emailDataModel = EmailLoginDataModel(
                        canShowResetPassword: canShowResetPassword,
                        emailLogin: dataModel.emailLogin(email:password:)
                    )
                    
                    EmailLoginView(isEditingTextFields: $isEditingTextFields,
                                   dataModel: emailDataModel)
                    
                    OtherLoginOptionsView(appleSignIn: dataModel.appleSignIn(tokenInfo:), googleSignIn: dataModel.googleSignIn)
                        .onlyShow(when: !isEditingTextFields)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            } else {
                VStack {
                    if let titleImage =  titleImage {
                        titleImage
                            .resizable()
                            .frame(width: getHeightPercent(30), height: getHeightPercent(30))
                            .padding()
                    } else {
                        Spacer()
                    }
                    
                    VStack(spacing: getHeightPercent(1))  {
                        Text("Aisle say, shopping just got fun!")
                            .lineLimit(1)
                            .setCustomFont(.headline, textColor: loginColors.tagLineColor, autoSize: true)
                            .padding(.horizontal, 10)
                        
                        Text("Grocery bliss in a click. Taking the guesswork out of grocery shopping and recipe planning.")
                            .multilineTextAlignment(.center)
                            .setCustomFont(.caption, isSmooth: true, textColor: loginColors.subTagLineColor)
                            .padding(.horizontal)
                    }
                    .padding(.vertical, getHeightPercent(3))
                    
                    AsyncTryButton(action: dataModel.guestSignIn) {
                        Text("Get Started")
                            .setCustomFont(.headline, textColor: loginColors.getStartedTextColor)
                            .frame(maxWidth: getWidthPercent(80))
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                    .tint(loginColors.getStartedButtonColor)
                    
                    Spacer()
                }
            }
            
            Button(action: { showingLoginOptions.toggle() }) {
                Text("\(showingLoginOptions ? "Don't" : "Already") have an account?")
                    .underline()
                    .setCustomFont(.caption, textColor: loginColors.accountButtonColor)
            }
            .onlyShow(when: !isEditingTextFields)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}


// MARK: - Preview
struct NnLoginView_Previews: PreviewProvider {
    static var previews: some View {
        NnLoginView(dataModel: dataModel, titleImage: Image(systemName: "house"), canShowResetPassword: true, loginColors: LoginViewColors())
    }
    
    static var dataModel: NnLoginDataModel {
        NnLoginDataModel(auth: MockAuth())
    }
    
    class MockAuth: NnLoginAuth {
        func guestSignIn() async throws { }
        func emailLogin(email: String, password: String) async throws { }
        func appleSignIn(tokenInfo: AppleTokenInfo) async throws { }
        func googleSignIn(tokenInfo: GoogleTokenInfo) async throws { }
    }
}


// MARK: - Dependencies
public struct LoginViewColors {
    var appTitleColor: Color = .primary
    var tagLineColor: Color = .primary
    var subTagLineColor: Color = .secondary
    var getStartedTextColor: Color = Color(uiColor: .systemBackground)
    var getStartedButtonColor: Color = .primary
    var accountButtonColor: Color = .primary
    
    var emailLoginColors: EmailLoginColors = EmailLoginColors()
}
