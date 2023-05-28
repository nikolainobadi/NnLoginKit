//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import Foundation

//
//  NnLoginFontViewModifier.swift
//  iCleanMe2
//
//  Created by Nikolai Nobadi on 12/23/22.
//  Copyright © 2022 Nikolai Nobadi. All rights reserved.
//

import SwiftUI

struct NnLoginFontViewModifier: ViewModifier {
    let font: Font
    let textColor: Color
    let autoSize: Bool
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(textColor)
            .minimumScaleFactor(autoSize ? 0.5 : 1)
    }
}

extension View {
//    func setLoginFont(_ style: Font.TextStyle, isSmooth: Bool = false, textColor: Color = .primary, autoSize: Bool = false) -> some View {
//        modifier(NnLoginFontViewModifier(font: makeFont(style, isSmooth: isSmooth), textColor: textColor, autoSize: autoSize))
//    }
}

//private extension View {
//    func makeFont(_ style: Font.TextStyle, isSmooth: Bool) -> Font { Font.custom(isSmooth ? "Thonburi" : "MarkerFelt-Thin", size: makeFontSize(style)) }
//}
