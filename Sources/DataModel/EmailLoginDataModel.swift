//
//  EmailLoginDataModel.swift
//  
//
//  Created by Nikolai Nobadi on 5/27/23.
//

import Foundation

final class EmailLoginDataModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirm = ""
    @Published private(set) var loginFieldError: NnLoginFieldError?
    
    let showResetPassword: (() -> Void)?
    private let emailLogin: (String, String) async throws -> Void
    
    init(showResetPassword: (() -> Void)?, emailLogin: @escaping (String, String) async throws -> Void) {
        self.showResetPassword = showResetPassword
        self.emailLogin = emailLogin
    }
}


// MARK: - ViewModel
extension EmailLoginDataModel {
    var loginErrorMessage: String? { loginFieldError?.message }
    
    func tryLogin() async throws {
        do {
            try LoginInfoValidator.validateInfo(email: email, password: password, confirm: showResetPassword == nil ? confirm : nil)
            try await emailLogin(email, password)
        } catch let loginFieldError as NnLoginFieldError {
            self.loginFieldError = loginFieldError
        } catch {
            throw error
        }
    }
}
