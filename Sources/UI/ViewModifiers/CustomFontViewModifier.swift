//
//  CustomFontViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 5/29/23.
//

import UIKit
import SwiftUI

internal struct CustomFontViewModifier: ViewModifier {
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

internal extension View {
    func setCustomFont(_ style: Font.TextStyle, isSmooth: Bool = false, textColor: Color = .primary, autoSize: Bool = false) -> some View {
        modifier(CustomFontViewModifier(font: makeFont(style, isSmooth: isSmooth), textColor: textColor, autoSize: autoSize))
    }
    
    func setCustomFont(size: CGFloat, textColor: Color = .primary, autoSize: Bool = false) -> some View {
        modifier(CustomFontViewModifier(font: Font.custom("Thonburi", size: size), textColor: textColor, autoSize: autoSize))
    }
}

private extension View {
    func makeFont(_ style: Font.TextStyle, isSmooth: Bool) -> Font { Font.custom(isSmooth ? "Thonburi" : "MarkerFelt-Thin", size: makeFontSize(style)) }
    func makeFontSize(_ style: Font.TextStyle) -> CGFloat {
        switch style {
        case .largeTitle: return getHeightPercent(7)
        case .title: return getHeightPercent(6)
        case .title2: return getHeightPercent(4.8)
        case .title3: return getHeightPercent(4)
        case .headline: return getHeightPercent(3.5)
        case .subheadline: return getHeightPercent(3)
        case .body: return getHeightPercent(2.5)
        case .caption: return getHeightPercent(2)
        case .caption2: return getHeightPercent(1.8)
        default: return 8
        }
    }
}



