//
//  LoginViewConfig.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import UIKit

public struct LoginViewConfig {
    
    public let titleColor: UIColor?
    public let buttonColor: UIColor?
    public let buttonTextColor: UIColor?
    public let backgroundColor: UIColor?
    
    public init(titleColor: UIColor?,
                buttonColor: UIColor?,
                buttonTextColor: UIColor?,
                backgroundColor: UIColor?) {
        
        self.titleColor = titleColor
        self.buttonColor = buttonColor
        self.buttonTextColor = buttonTextColor
        self.backgroundColor = backgroundColor
    }
}

