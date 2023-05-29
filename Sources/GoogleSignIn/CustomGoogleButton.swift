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
                    .setCustomFont(.caption, isSmooth: true, textColor: colorScheme == .dark ? .white : .black)
                Spacer()
            }
        }
        .padding(2)
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color(red: 244/255, green: 245/255, blue: 246/255)
))
    }
}
