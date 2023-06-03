//
//  LabelledDivider.swift
//  
//
//  Created by Nikolai Nobadi on 5/29/23.
//

import SwiftUI

internal struct LabelledDivider: View {
    let text: String

    private var color: Color { .gray }
    private var height: CGFloat { 2 }
    
    var body: some View {
        HStack {
            color.frame(height: height)
            Text(text)
                .foregroundColor(color)
            color.frame(height: height)
        }
    }
}
