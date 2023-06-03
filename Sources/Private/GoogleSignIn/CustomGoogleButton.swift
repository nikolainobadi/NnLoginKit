//
//  CustomGoogleButton.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI
import GoogleSignIn

struct CustomGoogleButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    let googleSignIn: (GoogleTokenInfo?) async throws -> Void
    
    private var size: CGFloat { 10 }
    
    var body: some View {
        AsyncTryButton(action: { try await googleSignIn(GoogleSignInHandler.createGoogleIdToken()) }) {
            HStack(spacing: 10) {
                Spacer()
                Image("Google", bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: getWidthPercent(size), height: getWidthPercent(size))
                    
                Text("Sign in with Google")
                    .setCustomFont(.caption, isSmooth: true, textColor: .black)
                Spacer()
            }
        }
        .padding(2)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(red: 244/255, green: 245/255, blue: 246/255))
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            )
    }
}

struct CustomGoogleButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomGoogleButton(googleSignIn: { _ in })
            .padding()
    }
}
