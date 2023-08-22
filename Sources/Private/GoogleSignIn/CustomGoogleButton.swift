//
//  CustomGoogleButton.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI

struct CustomGoogleButton: View {
    let googleSignIn: (GoogleTokenInfo?) async throws -> Void
    
    var body: some View {
        SocialMediaLoginButton(imageName: "Google", buttonText: "Continue with Google") {
            try await googleSignIn(GoogleSignInHandler.createGoogleIdToken())
        }
    }
}


// MARK: - Preview
struct CustomGoogleButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomGoogleButton(googleSignIn: { _ in })
            .padding()
    }
}
