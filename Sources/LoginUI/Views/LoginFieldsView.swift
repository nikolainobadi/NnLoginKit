//
//  LoginFieldsView.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import UIKit
import NnUIKitHelpers

public final class LoginFieldsView: NnView {
    
    // MARK: - Properties
    private let emailSignIn: () -> Void
    private let forgotPassword: () -> Void
    
    private var selectedFieldIndex = -1
    private var fields: [ShadowField] {
        [emailField, passwordField.field, confirmField.field]
    }
    
    
    // MARK: - Views
    lazy var toolBar: UIToolbar = {
        TextFieldToolBar { [weak self] in
            self?.chooseNextResponder()
        } onCancelTapped: { [weak self] in
            self?.endEditing(true)
        }
    }()
    
    lazy var emailField: ShadowField = {
        ShadowField("email...", withErrorLabel: true)
            .setTag(0)
    }()
    
    lazy var passwordField: PasswordField = {
        PasswordField("password...", tag: 1)
    }()
    
    lazy var confirmField: PasswordField = {
        PasswordField("confirm password...", tag: 2)
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        ShadowButton("Forgot Password?", buttonType: .naked)
            .underline()
            .setFont(.smallDetail, fontName: .thonburi)
            .setAction { [weak self] in
                self?.forgotPassword()
            }
    }()
    
    
    // MARK: - Init
    public init(emailSignIn: @escaping () -> Void,
                forgotPassword: @escaping () -> Void) {
        
        self.emailSignIn = emailSignIn
        self.forgotPassword = forgotPassword
        super.init(color: .clear)
        setupFields()
    }
    
    
    // MARK: - Display Setup
    public override func addSubviews() {
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(confirmField)
        addSubview(forgotPasswordButton)
    }
    
    public override func setupConstraints() {
        emailField.anchorCenterXToSuperview()
        emailField.anchor(safeTopAnchor,
                          topConstant: heightPercent(1) / 2,
                          widthConstant: widthPercent(80),
                          heightConstant: buttonHeight)
        
        passwordField.anchorCenterXToSuperview()
        passwordField.anchor(emailField.bottomAnchor,
                             topConstant: heightPercent(1) / 2,
                             widthConstant: widthPercent(80),
                             heightConstant: buttonHeight)
        
        confirmField.anchorCenterXToSuperview()
        confirmField.anchor(passwordField.bottomAnchor,
                            topConstant: heightPercent(1) / 2,
                            widthConstant: widthPercent(80),
                            heightConstant: buttonHeight)
        
        forgotPasswordButton.anchor(passwordField.bottomAnchor,
                                    right: rightAnchor,
                                    rightConstant: widthPercent(5),
                                    heightConstant: buttonHeight)
    }
}


// MARK: TextFieldDelegate
extension LoginFieldsView: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        chooseNextResponder()
        return true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        selectedFieldIndex = textField.tag
        
        return true
    }
}


// MARK: - Helper Methods
extension LoginFieldsView {
    
    public func updateView(isSignUp: Bool,
                           emailError: String,
                           passwordError: String,
                           confirmError: String) {
        
        emailField.setErrorMessage(emailError)
        passwordField.setErrorMessage(passwordError)
        confirmField.setErrorMessage(confirmError)
        configureAlphas(isSignUp: isSignUp)
    }
    
    private func configureAlphas(isSignUp: Bool) {
        confirmField.alpha = isSignUp ? 1 : 0
        forgotPasswordButton.alpha = isSignUp ? 0 : 1
    }
    
    private func setupFields() {
        fields.forEach { $0.inputAccessoryView = toolBar }
        fields.forEach { $0.delegate = self }
    }
    
    private func chooseNextResponder() {
        let endNum = confirmField.alpha == 0 ? 1 : 2
        guard selectedFieldIndex != endNum else {
            return loginOrDismiss()
        }
        
        let nextIndex = selectedFieldIndex + 1
        let nextResponder = fields[nextIndex]
        
        nextResponder.becomeFirstResponder()
        selectedFieldIndex = nextIndex
    }
    
    private var canLogin: Bool {
        let email = emailField.text ?? ""
        let pwd = passwordField.field.text ?? ""
        let confirm = confirmField.field.text ?? ""
        
        var canLogin = email != "" && pwd != ""
        
        if selectedFieldIndex == 2 {
            canLogin = canLogin && confirm != ""
        }
        
        return canLogin
    }
    
    private func loginOrDismiss() {
        if canLogin { return emailSignIn() }
        
        endEditing(true)
    }
}
