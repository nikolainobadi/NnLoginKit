//
//  Composer.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI

public typealias EmailLoginInfo = (email: String, password: String)

public func makeLoginView(colorOptions: LoginColorOptions = LoginColorOptions(), guestLogin: (() async throws -> Void)? = nil, emailLogin: ((EmailLoginInfo) async throws -> Void)? = nil, emailSignUp: (@escaping (EmailLoginInfo) async throws -> Void), resetPassword: (() async throws -> Void)? = nil) -> some View {
    
    let dataModel = LoginDataModel(colorOptions: colorOptions, guestLogin: guestLogin, emailLogin: emailLogin, emailSignUp: emailSignUp)
    let resetView = makeResetPasswordView(colorOptions: colorOptions, resetPassword: resetPassword ?? emptyMethod)
    
    return LoginView(dataModel: dataModel, resetView: resetView, canShowResetView: resetPassword != nil)
}

/// used as a filler method when resetPassword is nil
private func emptyMethod() async throws { }
private func makeResetPasswordView(colorOptions: LoginColorOptions, resetPassword: (@escaping () async throws -> Void)) -> some View {
    return ResetPasswordView(dataModel: ResetPasswordDataModel(colorOptions: colorOptions, sendResetPassswordEmail: resetPassword))
}
