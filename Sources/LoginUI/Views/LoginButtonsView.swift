//
//  LoginButtonsView.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import UIKit
import NnUIKitHelpers

public final class LoginButtonsView: NnView {
    
    // MARK: - Properties
    private let buttonColor: UIColor?
    private let buttonTextColor: UIColor?
    private let onlySignUp: Bool
    private let guestLogin: () -> Void
    private let emailSignIn: () -> Void
    
    @Published var isSignUp: Bool = true
    
    
    // MARK: - Views
    lazy var loginButton: UIButton = {
        ShadowButton()
            .addBorder()
            .setEnabled(false)
            .setColor(buttonTextColor, backgroundColor: buttonColor)
            .setAction { [weak self] in
                self?.emailSignIn()
            }
    }()
    
    lazy var accountButton: UIButton = {
        ShadowButton(buttonType: .naked)
            .setAlpha(onlySignUp ? 0 : 1)
            .setFont(.smallDetail, fontName: .thonburi)
            .setAction { [weak self] in
                self?.isSignUp.toggle()
            }
    }()
    
    lazy var guestLoginButton: UIButton = {
        ShadowButton("Login as guest", buttonType: .naked)
            .underline()
            .setFont(.smallDetail, fontName: .thonburi)
            .setAlpha(onlySignUp ? 0 : 1)
            .setAction { [weak self] in
                self?.guestLogin()
            }
    }()
    
    
    // MARK: - Init
    public init(buttonColor: UIColor?,
                buttonTextColor: UIColor?,
                onlySignUp: Bool = false,
                guestLogin: @escaping () -> Void,
                emailSignIn: @escaping () -> Void) {
        
        self.buttonColor = buttonColor
        self.buttonTextColor = buttonTextColor
        self.onlySignUp = onlySignUp
        self.guestLogin = guestLogin
        self.emailSignIn = emailSignIn
        super.init(color: .clear)
    }
    
    
    // MARK: - Display Setup
    public override func addSubviews() {
        addSubview(loginButton)
        addSubview(accountButton)
        addSubview(guestLoginButton)
    }
    
    public override func setupConstraints() {
        loginButton.anchorCenterXToSuperview()
        loginButton.anchor(safeTopAnchor,
                           widthConstant: widthPercent(70),
                           heightConstant: buttonHeight)

        accountButton.anchorCenterXToSuperview()
        accountButton.anchor(loginButton.bottomAnchor,
                             topConstant: heightPercent(1))

        guestLoginButton.anchorCenterXToSuperview()
        guestLoginButton.anchor(bottom: safeBottomAnchor,
                          bottomConstant: heightPercent(2))
    }
}


// MARK: - Helper Methods
extension LoginButtonsView {
    
    public func updateView(isReady: Bool,
                           loginTitle: String,
                           accountTitle: String) {
        
        loginButton.isEnabled = isReady
        loginButton.alpha = isReady ? 1 : 0.5
        
        loginButton.setTitle(loginTitle, for: .normal)
        setAccountTitle(accountTitle)
        configureGuestLoginButton(hide: loginTitle == "Login")
    }
    
    private func setAccountTitle(_ title: String) {
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0,
            length: attributedString.length))
        
        accountButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    private func configureGuestLoginButton(hide: Bool) {
        guard !onlySignUp else { return }
        
        guestLoginButton.alpha = hide ? 0 : 1
    }
}
