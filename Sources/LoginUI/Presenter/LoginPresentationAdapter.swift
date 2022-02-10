//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import Combine

public final class LoginPresentationAdapter {
    
    // MARK: - Properties
    @Published var state = LoginState()
    
    
    // MARK: - Init
    public init() { }
}


// MARK: - Presenter
extension LoginPresentationAdapter: LoginPresenter {
    
    public var viewModelPublisher: AnyPublisher<LoginViewModel, Never> {
        $state.map({ LoginViewModel($0) }).eraseToAnyPublisher()
    }
    
    public func updateEmail(_ email: String) {
        state.email = email
    }
    
    public func updatePassword(_ password: String) {
        state.password = password
    }
    
    public func updateConfirm(_ confirm: String) {
        state.confirm = confirm
    }
    
    public func updateIsSignUp(_ isSignUp: Bool) {
        state.isSignUp = isSignUp
    }
}
