//
//  Composer.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI

/// Creates an instance of `NnLoginView` with the provided configuration options.
///
/// - Parameters:
///   - titleImage: An optional `Image` to be used as the title image in the login view. Defaults to `nil`.
///   - textConfig: An `NnLoginTextConfig` instance containing the textual content to be displayed in the login view.
///   - colorsConfig: An `NnLoginColorsConfig` instance containing the color scheme for the login view. Defaults to a default `NnLoginColorsConfig`.
///   - auth: An `NnLoginAuth` instance for handling the authentication process.
///
/// - Returns: A `View` instance configured as a login screen with the provided options.
public func makeLoginView(titleImage: Image? = nil, textConfig: NnLoginTextConfig, colorsConfig: NnLoginColorsConfig = NnLoginColorsConfig(), auth: NnLoginAuth) -> some View {
    let dataModel = NnLoginDataModel(auth: auth)
    
    return NnLoginView(dataModel: dataModel, titleImage: titleImage, textConfig: textConfig, colorsConfig: colorsConfig)
}


public func makeAccountLinkView(sectionTitle: String = "Sign-in Methods", linkButtonTint: Color = .blue, auth: NnAccountLinkAuth, isLoading: Binding<Bool>, setAuthenticationStatus: ((Bool) -> Void)? = nil) -> some View {
    
    let dataModel = AccountLinkDataModel(auth: auth, setAuthenticationStatus: setAuthenticationStatus)
    
    return AccountLinkView(isLoading: isLoading, dataModel: dataModel, sectionTitle: sectionTitle, linkButtonTint: linkButtonTint)
}
