//
//  ConfigureLoginView.swift
//  

import Foundation

func makeLoginColorsConfig() -> NnLoginColorsConfig {
    NnLoginColorsConfig(titleColor: .purple,
                        detailsColor: .secondary,
                        buttonTextColor: .white,
                        buttonBackgroundColor: .purple,
                        underlinedButtonColor: .purple,
                        viewBackgroundColor: .color(.white),
                        textFieldTint: .purple,
                        errorTextColor: .red)
}
