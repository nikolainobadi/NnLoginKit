//
//  ConditionalDisplayViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI

internal struct ConditionalDisplayViewModifier: ViewModifier {
    let conditional: Bool
    
    func body(content: Content) -> some View {
        if conditional {
            content
        }
    }
}

internal extension View {
    func onlyShow(when conditional: Bool) -> some View {
        modifier(ConditionalDisplayViewModifier(conditional: conditional))
    }
}

