//
//  CustomAppleButton.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI
import CryptoKit
import AuthenticationServices

struct CustomAppleButton: View {
    @State private var currentNonce: String?
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var loadingHandler: LoadingHandler
    @EnvironmentObject var errorHandler: LoginErrorHandler
    
    let appleSignIn: (AppleTokenInfo) throws -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "apple.logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 26, height: 26)
                    .frame(height: 45)
                
                Text("Sign in with Apple")
                    .padding(.horizontal, getWidthPercent(2))
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(Color(uiColor: .systemBackground))
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.primary))
            .overlay {
                SignInWithAppleButton { request in
                    loadingHandler.startLoading()
                    request.requestedScopes = [.email]
                    let nonce = NonceFactory.randomNonceString()
                    currentNonce = nonce
                    request.nonce = NonceFactory.sha256(nonce)
                } onCompletion: { result in
                    switch result {
                    case .success(let authorization):
                        if let info = AppleSignInCredentialInfoFactory.convertCredential(auth: authorization, currentNonce: currentNonce) {
                            do {
                                try appleSignIn(info)
                            } catch {
                                handleError(error)
                            }
                        }
                    case .failure(let error):
                        handleError(error)
                    }
                    loadingHandler.stopLoading()
                }
                .blendMode(.overlay)
            }
            .clipped()
        }
    }
}


// MARK: - Private
private extension CustomAppleButton {
    func handleError(_ error: Error) {
        if let appleSignInError = error as? ASAuthorizationError, appleSignInError.code == .canceled {
            print("user cancelled sign in, no action necessary")
        } else {
            print(error.localizedDescription)
            errorHandler.handle(error: error)
        }
    }
}

