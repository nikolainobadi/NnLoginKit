//
//  CustomAppleButton.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI

struct CustomAppleButton: View {
    let appleSignIn: (AppleTokenInfo?) async throws -> Void
    
    var body: some View {
        SocialMediaLoginButton(imageName: "appleIcon", buttonText: "Continue with Apple") {
            try await appleSignIn(AppleSignInCoordinator().createAppleTokenInfo())
        }
    }
}
