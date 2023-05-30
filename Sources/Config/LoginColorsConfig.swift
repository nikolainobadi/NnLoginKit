//
//  LoginColorsConfig.swift
//  
//
//  Created by Nikolai Nobadi on 5/30/23.
//

import SwiftUI

public struct LoginColorsConfig {
    var titleColor: NnLoginColor
    var buttonTextColor: NnLoginColor
    var buttonBackgroundColor: NnLoginColor
    var underlinedButtonColor: NnLoginColor
    var viewBackgroundColor: NnLoginColor
    var textFieldTint: NnLoginColor
    var errorTextColor: NnLoginColor
    
    public init(titleColor: NnLoginColor = .color(.primary),
                buttonTextColor: NnLoginColor = .color(Color(uiColor: .systemBackground)),
                buttonBackgroundColor: NnLoginColor = .color(.primary),
                underlinedButtonColor: NnLoginColor = .color(.primary),
                viewBackgroundColor: NnLoginColor = .color(Color(uiColor: .systemBackground)),
                textFieldTint: NnLoginColor = .color(.primary),
                errorTextColor: NnLoginColor = .color(.red)) {
        
        self.titleColor = titleColor
        self.buttonTextColor = buttonTextColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.underlinedButtonColor = underlinedButtonColor
        self.viewBackgroundColor = viewBackgroundColor
        self.textFieldTint = textFieldTint
        self.errorTextColor = errorTextColor
    }
}

public enum NnLoginColor {
    case color(Color)
    case gradient(LinearGradient)
}
