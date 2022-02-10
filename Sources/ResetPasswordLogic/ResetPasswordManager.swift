//
//  ResetPasswordManager.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import LoginLogic

public final class ResetPasswordManager {
    
    // MARK: - Properties
    private let auth: ResetAuthorizer
    private let alerts: ResetPasswordAlerts
    private let dismiss: () -> Void

    
    // MARK: - Init
    public init(auth: ResetAuthorizer,
                alerts: ResetPasswordAlerts,
                dismiss: @escaping () -> Void) {
        
        self.auth = auth
        self.alerts = alerts
        self.dismiss = dismiss
    }
}


// MARK: UIResponder
extension ResetPasswordManager {
    
    public func resetPassword(_ email: String) {
        let emailError = Validator.validate(email, with: [.validEmail])
        guard email != "" && emailError == "" else {
            return alerts.showErrorMessage(emailError)
        }
        
        auth.resetPassword(email) { [weak self] error in
            if let error = error {
                self?.alerts.showError(error)
            } else {
                self?.showEmailSent()
            }
        }
    }
}


// MARK: - Private Methods
private extension ResetPasswordManager {
    
    func showEmailSent() {
        alerts.showDidSendEmailAlert { [weak self] in
            self?.dismiss()
        }
    }
}


// MARK: - Dependecies
public protocol ResetPasswordAlerts {
    func showError(_ error: Error)
    func showErrorMessage(_ message: String)
    func showDidSendEmailAlert(completion: @escaping () -> Void)
}

public protocol ResetAuthorizer {
    func resetPassword(_ email: String,
                       completion: @escaping (Error?) -> Void)
}


