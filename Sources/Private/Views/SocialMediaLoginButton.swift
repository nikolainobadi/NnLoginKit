//
//  SwiftUIView 2.swift
//  
//
//  Created by Nikolai Nobadi on 8/21/23.
//

import SwiftUI
import NnSwiftUIErrorHandling

enum SocialMediaType {
    case apple
    case google
}



struct SocialMediaLoginButton: View {
    let imageName: String
    let buttonText: String
    let action: () async throws -> Void
    
    var body: some View {
        NnAsyncTryButton(action: action) {
            HStack {
                Image(imageName, bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .frame(height: 45)
                Text(buttonText)
                    .foregroundColor(.black)
                    .frame(maxWidth: getWidthPercent(50), alignment: .leading)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
