//
//  LoginRootView.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import UIKit
import Combine
import NnUIKitHelpers

public final class LoginRootView: NnView {
    
    // MARK: - Properties
    private let titleView: LoginTitleView
    private let fieldsView: LoginFieldsView
    private let buttonsView: LoginButtonsView
    

    // MARK: - Init
    public init(titleView: LoginTitleView,
                fieldsView: LoginFieldsView,
                buttonsView: LoginButtonsView,
                backgroundColor: UIColor?) {
        
        self.titleView = titleView
        self.fieldsView = fieldsView
        self.buttonsView = buttonsView
        super.init(color: backgroundColor)
    }
    
    
    // MARK: - Display Setup
    public override func addSubviews() {
        addSubview(titleView)
        addSubview(fieldsView)
        addSubview(buttonsView)
    }
    
    public override func setupConstraints() {
        titleView.anchor(safeTopAnchor,
                         left: leftAnchor,
                         bottom: fieldsView.topAnchor,
                         right: rightAnchor)
                
        fieldsView.anchor(centerYAnchor,
                           left: leftAnchor,
                           right: rightAnchor,
                           heightConstant: (buttonHeight + heightPercent(1)) * 4)

        buttonsView.anchor(fieldsView.bottomAnchor,
                            left: leftAnchor,
                            bottom: safeBottomAnchor,
                            right: rightAnchor)
    }
}


// MARK: - Interface
extension LoginRootView: LoginInterface {

    public var emailPublisher: AnyPublisher<String, Never> {
        fieldsView.emailField.textPublisher
            .compactMap { $0.trimmingCharacters(in: .whitespaces) }
            .eraseToAnyPublisher()
    }
    
    public var passwordPublisher: AnyPublisher<String, Never> {
        fieldsView.passwordField.field.textPublisher.eraseToAnyPublisher()
    }
    
    public var confirmPublisher: AnyPublisher<String, Never> {
        fieldsView.confirmField.field.textPublisher.eraseToAnyPublisher()
    }
    
    public var isSignUpPublisher: AnyPublisher<Bool, Never> {
        buttonsView.$isSignUp.eraseToAnyPublisher()
    }
    
    public func updateView(_ viewModel: LoginViewModel) {
        titleView.setTitle(viewModel.title)
        buttonsView.updateView(isReady: viewModel.ready,
                               loginTitle: viewModel.title,
                               accountTitle: viewModel.accountButtonTitle)
        fieldsView.updateView(isSignUp: viewModel.isSignUp,
                              emailError: viewModel.emailError,
                              passwordError: viewModel.passwordError,
                              confirmError: viewModel.confirmError)
    }
}

