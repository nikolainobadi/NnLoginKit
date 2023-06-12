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
///   - textConfig: An ``NnLoginTextConfig`` instance containing the textual content to be displayed in the login view.
///   - colorsConfig: An ``NnLoginColorsConfig`` instance containing the color scheme for the login view. Defaults to a default `NnLoginColorsConfig`.
///   - auth: An ``NnLoginAuth`` instance for handling the authentication process.
///
/// - Returns: A `View` instance configured as a login screen with the provided options.
public func makeLoginView(titleImage: Image? = nil, textConfig: NnLoginTextConfig, colorsConfig: NnLoginColorsConfig = NnLoginColorsConfig(), auth: NnLoginAuth) -> some View {
    let dataModel = NnLoginDataModel(auth: auth)
    
    return NnLoginView(dataModel: dataModel, titleImage: titleImage, textConfig: textConfig, colorsConfig: colorsConfig)
}


/// Creates an instance of `AccountLinkView` with the provided configuration options.
///
/// - Parameters:
///   - sectionTitle: A `String` representing the title of the section displaying the sign-in methods. Defaults to `"Sign-in Methods"`.
///   - linkButtonTint: A `Color` representing the tint color of the Link/Unlink button. Defaults to `.blue`.
///   - auth: An `NnAccountLinkAuth` instance for handling the linking and unlinking process.
///   - isLoading: A `Binding<Bool>` instance indicating whether the view is currently loading.
///   - setAuthenticationStatus: An optional closure invoked when the authentication status changes. It accepts a `Bool` parameter indicating the new authentication status. Defaults to `nil`.
///
/// - Returns: A `View` instance configured as an account link screen with the provided options.
public func makeAccountLinkView(sectionTitle: String = "Sign-in Methods", linkButtonTint: Color = .blue, auth: NnAccountLinkAuth, isLoading: Binding<Bool>, setAuthenticationStatus: ((Bool) -> Void)? = nil) -> some View {
    
    let dataModel = AccountLinkDataModel(auth: auth, setAuthenticationStatus: setAuthenticationStatus)
    
    return AccountLinkView(isLoading: isLoading, dataModel: dataModel, sectionTitle: sectionTitle, linkButtonTint: linkButtonTint)
}

