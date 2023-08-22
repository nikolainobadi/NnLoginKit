//
//  SoloViewComposer.swift
//  
//
//  Created by Nikolai Nobadi on 8/21/23.
//

import SwiftUI

enum SoloViewComposer {
    static func composeGoogleButton(signIn: @escaping (GoogleTokenInfo?) async throws -> Void) -> some View {
        return CustomGoogleButton(googleSignIn: signIn)
    }
    
    static func composeAppleButton(signIn: @escaping (AppleTokenInfo?) async throws -> Void) -> some View {
        return CustomAppleButton(appleSignIn: signIn)
    }
}
