//
//  LoginViewConfig.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import UIKit

public struct LoginViewConfig {
    
    public let imageView: UIView?
    public let titleColor: UIColor?
    public let buttonColor: UIColor?
    public let buttonTextColor: UIColor?
    public let backgroundColor: UIColor?
    
    public init(imageView: UIView? = nil,
                titleColor: UIColor? = .label,
                buttonColor: UIColor? = .label,
                buttonTextColor: UIColor? = .systemBackground,
                backgroundColor: UIColor? = .systemBackground) {
        
        self.imageView = imageView
        self.titleColor = titleColor
        self.buttonColor = buttonColor
        self.buttonTextColor = buttonTextColor
        self.backgroundColor = backgroundColor
    }
}

