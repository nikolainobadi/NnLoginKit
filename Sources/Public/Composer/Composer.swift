//
//  Composer.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI

public func makeLoginView(titleImage: Image? = nil, textConfig: LoginTextConfig, colorsConfig: LoginColorsConfig = LoginColorsConfig(), auth: NnLoginAuth) -> some View {
    let dataModel = NnLoginDataModel(auth: auth)
    
    return NnLoginView(dataModel: dataModel, titleImage: titleImage, textConfig: textConfig, colorsConfig: colorsConfig)
}

public func makeAccountLinkView(sectionTitle: String = "Sign-in Methods", linkButtonTint: Color = .blue, auth: NnAccountLinkAuth) -> some View {
    let dataModel = AccountLinkDataModel(auth: auth)
    
    return AccountLinkView(dataModel: dataModel, sectionTitle: sectionTitle, linkButtonTint: linkButtonTint)
}
