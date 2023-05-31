//
//  Composer.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI

public func makeLoginView(titleImage: Image? = nil, colorsConfig: LoginColorsConfig = LoginColorsConfig(), auth: NnLoginAuth, sendResetEmail: ((String) async throws -> Void)? = nil) -> some View {
    let dataModel = NnLoginDataModel(auth: auth)
    
    return NnLoginView(dataModel: dataModel, appTitle: "NnLoginKit Demo", titleImage: titleImage, colorsConfig: colorsConfig, sendResetEmail: sendResetEmail)
}
