//
//  NnLoginColorsConfig.swift
//  
//
//  Created by Nikolai Nobadi on 5/30/23.
//

import SwiftUI

/// `NnLoginColorsConfig` is a structure that encapsulates the color scheme for the `LoginView`.
/// It contains the color configuration for various elements that appear on the login screen.
public struct NnLoginColorsConfig {
    /// The color for the main title at the top of the login page.
    var titleColor: Color
    
    /// The color for any text that is not a title, nor in a textfield or button.
    var detailsColor: Color
    
    /// The color for the text inside of the larger buttons.
    var buttonTextColor: Color
    
    /// The color for the background of the buttons.
    var buttonBackgroundColor: Color
    
    /// The color for any buttons that appear with underlines, such as accountButton and forgotPasswordButton.
    var underlinedButtonColor: Color
    
    /// The overall color of the view. Can be a single color or a gradient.
    var viewBackgroundColor: NnLoginColor
    
    /// The color for the eye image that toggles password secure input.
    var textFieldTint: Color
    
    /// The color of the text displayed when there is a validation error with the email/password information inputted by the user.
    var errorTextColor: Color
    
    /// Initializes a new `NnLoginColorsConfig` instance with the provided color values.
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

/// `NnLoginColor` is an enumeration that represents either a single color or a gradient.
/// This enables the background of the `LoginView` to be customized with either a solid color or a gradient effect.
public enum NnLoginColor {
    /// A solid color.
    case color(Color)
    
    /// A gradient effect.
    case gradient(LinearGradient)
    
    /// Returns a `View` representing the color or gradient.
    /// You can use this view in a `.background()` view modifier to apply it to any view.
    ///
    /// # Example
    ///
    /// ```
    /// Text("Hello, World!")
    ///     .background(NnLoginColor.color(.blue).view())
    /// ```
    ///
    /// The above code will create a `Text` view with a blue background.
    ///
    /// You can similarly use `NnLoginColor.gradient(...)` to apply a gradient background.
    func view() -> some View {
        switch self {
        case .color(let color):
            return AnyView(color)
        case .gradient(let gradient):
            return AnyView(gradient)
        }
    }
}
