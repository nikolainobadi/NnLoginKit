//
//  NnResetPasswordViewConfig.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI
import Foundation

public struct NnResetPasswordViewConfig {
    var titleColor: Color
    var messageColor: Color
    var buttonBackground: Color
    var buttonText: Color
    var backgroundColor: Color
    
    public init(titleColor: Color = .primary, messageColor: Color = .primary, buttonBackground: Color = .primary, buttonText: Color = Color(uiColor: .systemBackground), backgroundColor: Color = Color(uiColor: .systemBackground)) {
        self.titleColor = titleColor
        self.messageColor = messageColor
        self.buttonBackground = buttonBackground
        self.buttonText = buttonText
        self.backgroundColor = backgroundColor
    }
}
