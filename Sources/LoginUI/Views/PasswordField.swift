//
//  PasswordField.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import UIKit
import NnUIKitHelpers

open class PasswordField: UIView {
    
    // MARK: - Views
    private let fieldTag: Int
    private let placeholder: String
    private let eyeOpen = UIImage(systemName: "eye")
    private let eyeShut = UIImage(systemName: "eye.slash")
    
    lazy var field: ShadowField = {
        let field = ShadowField(placeholder, nakedField: true, withErrorLabel: true)
            .setTag(fieldTag)
            .isPassword()
        
        field.textAlignment = .center
        field.keyboardAppearance = .dark
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .clear
        
        return field
    }()
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .clear
        button.setImage(eyeShut, for: .normal)
        button.addAction(makeToggleSecureAction(), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - Init
    public init(_ placeholder: String, tag: Int) {
        self.fieldTag = tag
        self.placeholder = placeholder
        super.init(frame: .zero)
        
        setConstraints()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        // background
        layer.backgroundColor = UIColor.systemBackground.cgColor
        
        // border
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = false
        
        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
    }
    
    
    // MARK: - Helpers
    public func setErrorMessage(_ message: String) {
        field.setErrorMessage(message)
    }
}


// MARK: - Private
private extension PasswordField {
    
    func makeToggleSecureAction() -> UIAction {
        UIAction { [weak self] _ in
            self?.toggleSecureEntry()
        }
    }
    
    func toggleSecureEntry() {
        field.isSecureTextEntry.toggle()
        eyeButton.setImage(field.isSecureTextEntry ? eyeShut : eyeOpen, for: .normal)
    }
    
    func setConstraints() {
        addSubview(field)
        addSubview(eyeButton)
        
        field.anchor(safeTopAnchor,
                     left: leftAnchor,
                     bottom: bottomAnchor,
                     right: rightAnchor,
                     leftConstant: widthPercent(1))
        
        eyeButton.anchor(safeTopAnchor,
                         bottom: safeBottomAnchor,
                         right: rightAnchor,
                         topConstant: heightPercent(0.5),
                         bottomConstant: heightPercent(0.5),
                         rightConstant: widthPercent(2),
                         widthConstant: widthPercent(10))
    }
}

