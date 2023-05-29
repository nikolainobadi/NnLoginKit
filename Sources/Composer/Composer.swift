//
//  Composer.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI

public typealias EmailLoginInfo = (email: String, password: String)

public func makeEmailLoginView(isEditingTextFields: Binding<Bool>? = nil, canShowResetPassword: Bool, emailLogin: @escaping (String, String) async throws -> Void) -> some View {
    let dataModel = EmailLoginDataModel(canShowResetPassword: canShowResetPassword, emailLogin: emailLogin)

    return EmailLoginView(isEditingTextFields: isEditingTextFields, dataModel: dataModel)
}

public func makeLoginView(colorOptions: LoginColorOptions = LoginColorOptions(), guestLogin: (() async throws -> Void)? = nil, emailLogin: ((EmailLoginInfo) async throws -> Void)? = nil, emailSignUp: (@escaping (EmailLoginInfo) async throws -> Void), resetPassword: ((String) async throws -> Void)? = nil) -> some View {
    
    let dataModel = LoginDataModel(colorOptions: colorOptions, guestLogin: guestLogin, emailLogin: emailLogin, emailSignUp: emailSignUp)
    let resetView = makeResetPasswordView(colorOptions: colorOptions, resetPassword: resetPassword ?? emptyMethod)
    
    return LoginView(dataModel: dataModel, resetView: resetView, canShowResetView: resetPassword != nil)
}

/// used as a filler method when resetPassword is nil
private func emptyMethod(_ email: String) async throws { }
private func makeResetPasswordView(colorOptions: LoginColorOptions, resetPassword: (@escaping (String) async throws -> Void)) -> some View {
    return ResetPasswordView(dataModel: ResetPasswordDataModel(colorOptions: colorOptions, sendResetPassswordEmail: resetPassword))
}
