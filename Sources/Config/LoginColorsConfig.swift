//
//  LoginColorsConfig.swift
//  
//
//  Created by Nikolai Nobadi on 5/30/23.
//

import SwiftUI

public struct LoginColorsConfig {
    var titleColor: Color
    var detailsColor: Color
    var buttonTextColor: Color
    var buttonBackgroundColor: Color
    var underlinedButtonColor: Color
    var viewBackgroundColor: NnLoginColor
    var textFieldTint: Color
    var errorTextColor: Color
    
    public init(titleColor: Color = .primary,
                detailsColor: Color = .secondary,
                buttonTextColor: Color = Color(uiColor: .systemBackground),
                buttonBackgroundColor: Color = .primary,
                underlinedButtonColor: Color = .primary,
                viewBackgroundColor: NnLoginColor = .color(Color(uiColor: .systemBackground)),
                textFieldTint: Color = .primary,
                errorTextColor: Color = .red) {
        
        self.titleColor = titleColor
        self.detailsColor = detailsColor
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
    
    func view() -> some View {
        switch self {
        case .color(let color):
            return AnyView(color)
        case .gradient(let gradient):
            return AnyView(gradient)
        }
    }
}
