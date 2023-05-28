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
    
    var body: some View {
        AsyncTryButton(action: { try await googleSignIn(GoogleSignInHandler.createGoogleIdToken()) }) {
            HStack {
                Image("Google")
                Text("Sign in with Google")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
