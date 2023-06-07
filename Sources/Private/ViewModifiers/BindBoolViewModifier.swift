//
//  BindBoolViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 6/6/23.
//

import SwiftUI

internal struct BindBoolViewModifier: ViewModifier {
    @Binding var viewBool: Bool
    @Binding var publishedBool: Bool
    
    let animate: Bool
    
    func body(content: Content) -> some View {
        if animate {
            content
                .onChange(of: viewBool, perform: { newValue in
                    withAnimation { publishedBool = newValue }
                })
                .onChange(of: publishedBool, perform: { newValue in
                    withAnimation { viewBool = newValue }
                })
        } else {
            content
                .onChange(of: viewBool, perform: { publishedBool = $0 })
                .onChange(of: publishedBool, perform: { viewBool = $0 })
        }
    }
}

internal extension View {
    func bindBool(viewBool: Binding<Bool>, publishedBool: Binding<Bool>, animate: Bool = false) -> some View {
        modifier(BindBoolViewModifier(viewBool: viewBool, publishedBool: publishedBool, animate: animate))
    }
}
