//
//  ResetPasswordDataModel.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import Foundation

final class ResetPasswordDataModel: ObservableObject {
    @Published var email = ""
    @Published var error: Error?
    
    private let colorOptions: LoginColorOptions
    private let sendResetPassswordEmail: () async throws -> Void
    
    init(colorOptions: LoginColorOptions, sendResetPassswordEmail: @escaping () -> Void) {
        self.colorOptions = colorOptions
        self.sendResetPassswordEmail = sendResetPassswordEmail
    }
}


// MARK: - View Model
extension ResetPasswordDataModel {
    var colors: LoginColorOptions { colorOptions }
    var disableButton: Bool { email.count < 6 || !email.contains("@") || !email.contains(".") }
    var message: String { "Enter your email address and a link will be sent allowing you to reset your password." }
    
    func resetPassword() {
        Task {
            do {
                try await sendResetPassswordEmail()
            } catch {
                await showError(error)
            }
        }
    }
}


// MARK: - Main Actor
private extension ResetPasswordDataModel {
    @MainActor func showError(_ error: Error) { self.error = error }
}
