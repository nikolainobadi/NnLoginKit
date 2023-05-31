//
//  Composer.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI

public func makeLoginView(appTitle: String, titleImage: Image? = nil, colorsConfig: LoginColorsConfig = LoginColorsConfig(), auth: NnLoginAuth) -> some View {
    let dataModel = NnLoginDataModel(auth: auth)
    
    return NnLoginView(dataModel: dataModel, appTitle: appTitle, titleImage: titleImage, colorsConfig: colorsConfig)
}
