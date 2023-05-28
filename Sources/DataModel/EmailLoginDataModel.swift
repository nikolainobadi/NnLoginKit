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
    
    let canShowResetPassword: Bool
    private let emailLogin: (String, String) -> Void
    
    /// Initializes an EmailLoginDataModel.
    ///
    /// - Parameters:
    ///   - canShowResetPassword: A boolean value indicating whether to show the "Forgot Password?" button (if `true`)
    ///                           or the "Confirm Password" text field (if `false`).
    ///   - emailLogin: A closure that will be called for email login with the entered email and password.
    init(canShowResetPassword: Bool, emailLogin: @escaping (String, String) -> Void) {
        self.canShowResetPassword = canShowResetPassword
        self.emailLogin = emailLogin
    }
}



// MARK: - ViewModel
extension EmailLoginDataModel {
    var loginErrorMessage: String? { loginFieldError?.message }
    
    func tryLogin() {
        do {
            try LoginInfoValidator.validateInfo(email: email, password: password, confirm: canShowResetPassword ? nil : confirm)
            
            emailLogin(email, password)
        } catch let loginFieldError as NnLoginFieldError {
            self.loginFieldError = loginFieldError
        } catch {
            print("unexpected error: \(error.localizedDescription)")
        }
    }
}
