//
//  Composer.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI

public func makeEmailLoginView(isEditingTextFields: Binding<Bool>? = nil, canShowResetPassword: Bool, emailLogin: @escaping (String, String) async throws -> Void) -> some View {
    let dataModel = EmailLoginDataModel(canShowResetPassword: canShowResetPassword, emailLogin: emailLogin)

    return EmailLoginView(isEditingTextFields: isEditingTextFields, dataModel: dataModel)
}

public func makeAppleSignInButton(appleSignIn: @escaping (AppleTokenInfo) throws -> Void) -> some View {
    return CustomAppleButton(appleSignIn: appleSignIn)
}

public func makeGoogleSignInButton(googleSignIn: @escaping (GoogleTokenInfo?) async throws -> Void) -> some View {
    return CustomGoogleButton(googleSignIn: googleSignIn)
}

public func makeLoginView(titleImage: Image? = nil, colorsConfig: LoginColorsConfig = LoginColorsConfig(), auth: NnLoginAuth) -> some View {
    let dataModel = NnLoginDataModel(auth: auth)
    
    return NnLoginView(dataModel: dataModel, titleImage: titleImage, colorsConfig: colorsConfig)
}
