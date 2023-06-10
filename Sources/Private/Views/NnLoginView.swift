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
    let textConfig: LoginTextConfig
    let colorsConfig: NnLoginColorsConfig
    
    var body: some View {
        VStack {
            Text(textConfig.appTitle)
                .lineLimit(1)
                .setCustomFont(.largeTitle, textColor: colorsConfig.titleColor, autoSize: true)
                .padding()
            
            if showingLoginOptions {
                VStack {
                    let emailDataModel = EmailLoginDataModel(
                        sendResetEmail: dataModel.sendResetPassword(email:),
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
                        Text(textConfig.tagline)
                            .lineLimit(1)
                            .setCustomFont(.headline, textColor: colorsConfig.titleColor, autoSize: true)
                            .padding(.horizontal, 10)
                        
                        Text(textConfig.subTagline)
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
        .withLoadingView()
        .withErrorHandling()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(colorsConfig.viewBackgroundColor.view().ignoresSafeArea())
    }
}


// MARK: - Preview
struct NnLoginView_Previews: PreviewProvider {
    static var previews: some View {
        NnLoginView(dataModel: dataModel, titleImage: Image(systemName: "house"), textConfig: LoginTextConfig(appTitle: "App Title", tagline: "This is a tagline", subTagline: "Here is a little more detail, just in case the tagline wasn't enough"), colorsConfig: NnLoginColorsConfig())
    }
    
    static var dataModel: NnLoginDataModel {
        NnLoginDataModel(auth: MockAuth())
    }
    
    class MockAuth: NnLoginAuth {
        func guestSignIn() async throws { }
        func emailLogin(email: String, password: String) async throws { }
        func sendResetEmail(email: String) async throws { }
        func appleSignIn(tokenInfo: AppleTokenInfo) async throws { }
        func googleSignIn(tokenInfo: GoogleTokenInfo) async throws { }
    }
}
