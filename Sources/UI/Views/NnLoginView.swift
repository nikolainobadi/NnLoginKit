//
//  NnLoginView.swift
//  
//
//  Created by Nikolai Nobadi on 5/29/23.
//

import SwiftUI

struct NnLoginView: View {
    @StateObject var dataModel: NnLoginDataModel
    @State private var showingLoginOptions = true
    @State private var isEditingTextFields = false
    
    let appTitle: String
    let titleImage: Image?
    let colorsConfig: LoginColorsConfig
    let sendResetEmail: ((String) async throws -> Void)?
    
    var body: some View {
        VStack {
            Text(appTitle)
                .lineLimit(1)
                .setCustomFont(.largeTitle, textColor: colorsConfig.titleColor, autoSize: true)
                .padding()
            
            if showingLoginOptions {
                VStack {
                    let emailDataModel = EmailLoginDataModel(
                        sendResetEmail: sendResetEmail,
                        emailLogin: dataModel.emailLogin(email:password:)
                    )
                    
                    EmailLoginView(isEditingTextFields: $isEditingTextFields,
                                   dataModel: emailDataModel,
                                   colorsConfig: colorsConfig)
                    
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
                            .setCustomFont(.headline, textColor: colorsConfig.titleColor, autoSize: true)
                            .padding(.horizontal, 10)
                        
                        Text("Grocery bliss in a click. Taking the guesswork out of grocery shopping and recipe planning.")
                            .multilineTextAlignment(.center)
                            .setCustomFont(.caption, isSmooth: true, textColor: colorsConfig.detailsColor)
                            .padding(.horizontal)
                    }
                    .padding(.vertical, getHeightPercent(3))
                    
                    AsyncTryButton(action: dataModel.guestSignIn) {
                        Text("Get Started")
                            .setCustomFont(.headline, textColor: colorsConfig.buttonTextColor)
                            .frame(maxWidth: getWidthPercent(80))
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                    .tint(colorsConfig.buttonBackgroundColor)
                    
                    Spacer()
                }
            }
            
            Button(action: { showingLoginOptions.toggle() }) {
                Text("\(showingLoginOptions ? "Don't" : "Already") have an account?")
                    .underline()
                    .setCustomFont(.caption, textColor: colorsConfig.underlinedButtonColor)
            }
            .onlyShow(when: !isEditingTextFields)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(colorsConfig.viewBackgroundColor.view().ignoresSafeArea())
    }
}


// MARK: - Preview
struct NnLoginView_Previews: PreviewProvider {
    static var previews: some View {
        NnLoginView(dataModel: dataModel, appTitle: "App Title", titleImage: Image(systemName: "house"), colorsConfig: LoginColorsConfig(), sendResetEmail: { _ in })
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
