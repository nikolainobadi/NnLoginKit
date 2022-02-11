//
//  ResetPasswordRootView.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import UIKit
import Combine
import NnUIKitHelpers

public final class ResetPasswordRootView: NnView {
    
    // MARK: - Properties
    private let config: ResetPasswordViewConfig
    private let responder: ResetPasswordUIResponder
    
    
    // MARK: - Views
    lazy var titleLabel: UILabel = {
        UILabel("Reset Password")
            .setColor(config.titleColor)
            .setAlignment(.center)
            .addShadow()
            .autoSize()
            .setFontByStyle(.largeTitle)
    }()
    
    lazy var closeButton: UIButton = {
        ShadowButton("X", buttonType: .naked)
            .setFont(.largeDetail)
            .setAction { [weak self] in
                self?.responder.finished()
            }
    }()
    
    lazy var detailsView: UILabel = {
        UILabel(detailsText)
            .multipleLines()
            .setAlignment(.center)
            .setFontByStyle(.detail,
                            fontName: .thonburi)
    }()
    
    public lazy var emailField: ShadowField = {
        ShadowField("Enter email...")
    }()
    
    lazy var resetPasswordButton: UIButton = {
        ShadowButton("Reset Password")
            .addBorder()
            .setColor(config.buttonTextColor,
                      backgroundColor: config.buttonColor)
            .setAction { [weak self] in
                self?.resetPassword()
            }
    }()
    
    
    // MARK: - Init
    public init(config: ResetPasswordViewConfig,
                responder: ResetPasswordUIResponder) {
        
        self.config = config
        self.responder = responder
        super.init(color: config.backgroundColor)
    }
    
    
    // MARK: - Display Setup
    public override func addSubviews() {
        addSubview(titleLabel)
        addSubview(closeButton)
        addSubview(detailsView)
        addSubview(emailField)
        addSubview(resetPasswordButton)
    }
    
    public override func setupConstraints() {
        closeButton.anchor(safeTopAnchor,
                           left: leftAnchor,
                           topConstant: heightPercent(1),
                           leftConstant: widthPercent(1))
        
        titleLabel.anchor(closeButton.bottomAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          leftConstant: widthPercent(2),
                          rightConstant: widthPercent(2))
        
        detailsView.anchor(titleLabel.bottomAnchor,
                           left: leftAnchor,
                           bottom: centerYAnchor,
                           right: rightAnchor,
                           topConstant: heightPercent(8),
                           leftConstant: widthPercent(2),
                           rightConstant: widthPercent(2))
        
        emailField.anchorCenterXToSuperview()
        emailField.anchor(centerYAnchor,
                          widthConstant: widthPercent(80),
                          heightConstant: buttonHeight)
        
        resetPasswordButton.anchorCenterXToSuperview()
        resetPasswordButton.anchor(emailField.bottomAnchor,
                                   topConstant: buttonHeight,
                                   widthConstant: widthPercent(80))
    }
}


// MARK: - Helpers
private extension ResetPasswordRootView {
    
    var detailsText: String {
        "Enter your email address and a link will be sent allowing you to reset your password."
    }
    
    func resetPassword() {
        responder.resetPassword(emailField.text ?? "")
    }
}


// MARK: - Dependencies
public typealias ResetPasswordUIResponder = (finished: () -> Void,
                                             resetPassword: (String) -> Void)
