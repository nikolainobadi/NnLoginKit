//
//  LoginManager.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import Combine

public final class LoginManager {
    
    // MARK: - Properties
    private let info: LoginInfo
    private let auth: EmailAuthorizer
    private let alerts: LoginAlerts
    private let finished: (UserSessionInfo) -> Void
    
    
    // MARK: - Init
    init(info: LoginInfo,
         auth: EmailAuthorizer,
         alerts: LoginAlerts,
         finished: @escaping (UserSessionInfo) -> Void) {
        
        self.info = info
        self.auth = auth
        self.alerts = alerts
        self.finished = finished
    }
}


// MARK: - UIResponder
extension LoginManager {
    
    public func emailSignIn() {
        auth.signIn(email: info.email,
                    password: info.password,
                    isSignUp: info.isSignUp,
                    completion: handleResult())
    }
    
    public func guestLogin() {
        auth.signInAnonymously(completion: handleResult())
    }
}


// MARK: - Private Methods
private extension LoginManager {
    
    func handleResult() -> ((Result<UserSessionInfo, Error>) -> Void) {
        return { [weak self] result in
            switch result {
            case .success(let session):
                self?.finished(session)
            case .failure(let error):
                self?.alerts.showError(error)
            }
        }
    }
}


// MARK: - Dependencies
public protocol LoginInfo {
    var email: String { get }
    var password: String { get }
    var isSignUp: Bool { get }
}

public protocol LoginAlerts {
    func showError(_ error: Error)
}

public protocol EmailAuthorizer {
    func signInAnonymously(completion: @escaping (Result<UserSessionInfo, Error>) -> Void)
    
    func signIn(email: String,
                password: String,
                isSignUp: Bool,
                completion: @escaping (Result<UserSessionInfo, Error>) -> Void)
}
