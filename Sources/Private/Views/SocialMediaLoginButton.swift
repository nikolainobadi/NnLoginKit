//
//  SwiftUIView 2.swift
//  
//
//  Created by Nikolai Nobadi on 8/21/23.
//

import SwiftUI
import NnSwiftUIErrorHandling

struct SocialMediaLoginButton: View {
    let imageName: String
    let buttonText: String
    let action: () async throws -> Void
    
    var body: some View {
        NnAsyncTryButton(action: action) {
            HStack {
                Image(imageName)
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

//struct SocialMediaLoginButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SocialMediaLoginButton()
//    }
//}
