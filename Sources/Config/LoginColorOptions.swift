//
//  LoginColorOptions.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI

struct LoginColorOptions {
    let title: Color
    let detailsText: Color
    let buttonText: Color
    let buttonBackground: Color
    let underlinedButtons: Color
    let viewBackground: Color
    let textFieldTint: Color
    let errorText: Color
    
    init(title: Color = .primary, detailsText: Color = .primary, buttonText: Color = Color(uiColor: .systemBackground), buttonBackground: Color = .primary, underlinedButtons: Color = .primary, viewBackground: Color = Color(uiColor: .systemBackground), textFieldTint: Color = .primary, errorText: Color = .red) {
        
        self.title = title
        self.detailsText = detailsText
        self.buttonText = buttonText
        self.buttonBackground = buttonBackground
        self.underlinedButtons = underlinedButtons
        self.viewBackground = viewBackground
        self.textFieldTint = textFieldTint
        self.errorText = errorText
    }
}
