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
    
    let sendResetEmail: ((String) async throws -> Void)?
    private let emailLogin: (String, String) async throws -> Void
    
    /// Initializes an EmailLoginDataModel.
    ///
    /// - Parameters:
    ///   - canShowResetPassword: A boolean value indicating whether to show the "Forgot Password?" button (if `true`)
    ///                           or the "Confirm Password" text field (if `false`).
    ///   - emailLogin: A closure that will be called for email login with the entered email and password.
    init(sendResetEmail: ((String) async throws -> Void)? = nil, emailLogin: @escaping (String, String) async throws -> Void) {
        self.sendResetEmail = sendResetEmail
        self.emailLogin = emailLogin
    }
}



// MARK: - ViewModel
extension EmailLoginDataModel {
    var canShowResetPassword: Bool { sendResetEmail != nil }
    var loginErrorMessage: String? { loginFieldError?.message }
    
    func tryLogin() async throws {
        do {
            try LoginInfoValidator.validateInfo(email: email, password: password, confirm: canShowResetPassword ? nil : confirm)
            
            try await emailLogin(email, password)
        } catch let loginFieldError as NnLoginFieldError {
            self.loginFieldError = loginFieldError
        } catch {
            print("unexpected error: \(error.localizedDescription)")
            throw error
        }
    }
}
