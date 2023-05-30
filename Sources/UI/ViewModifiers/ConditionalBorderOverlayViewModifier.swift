//
//  ConditionalBorderOverlayViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI

internal struct ConditionalBorderOverlayViewModifier: ViewModifier {
    let color: Color
    let showOverlay: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(
                VStack {
                    if showOverlay {
                        RoundedRectangle(cornerRadius: 10).stroke(.red)
                    }
                }
            )
    }
}

internal extension View {
    func withBorderOverlay(_ showOverlay: Bool, color: Color = .red) -> some View {
        modifier(ConditionalBorderOverlayViewModifier(color: color, showOverlay: showOverlay))
    }
}
