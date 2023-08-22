//
//  CustomGoogleButton.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI
import NnSwiftUIErrorHandling

struct CustomGoogleButton: View {
    let googleSignIn: (GoogleTokenInfo?) async throws -> Void
    
    private func signInAction() async throws {
        try await googleSignIn(GoogleSignInHandler.createGoogleIdToken())
    }
    
    var body: some View {
        NnAsyncTryButton(action: signInAction) {
            HStack {
                Image("Google", bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                Text("Continue with Google")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .frame(maxWidth: getWidthPercent(50), alignment: .leading)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
    }
}


// MARK: - Preview
struct CustomGoogleButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomGoogleButton(googleSignIn: { _ in })
            .padding()
    }
}
