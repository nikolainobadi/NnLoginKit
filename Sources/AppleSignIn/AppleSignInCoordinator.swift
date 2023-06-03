//
//  AppleSignInCoordinator.swift
//  
//
//  Created by Nikolai Nobadi on 6/3/23.
//

import AuthenticationServices

final class AppleSignInCoordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    var currentNonce: String?
    private var completion: ((Result<AppleTokenInfo, Error>) -> Void)?
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            fatalError("Unexpected window scene configuration.")
        }
        return window
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let info = AppleSignInCredentialInfoFactory.convertCredential(auth: authorization, currentNonce: currentNonce) {
            completion?(.success(info))
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        completion?(.failure(error))
    }
}


// MARK: - Handler
extension AppleSignInCoordinator {
    func createAppleTokenInfo() async throws -> AppleTokenInfo {
        return try await withCheckedThrowingContinuation { continuation in
            completion = { result in
                switch result {
                case .success(let info):
                    continuation.resume(returning: info)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
            
            currentNonce = NonceFactory.randomNonceString()
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.email]
            request.nonce = NonceFactory.sha256(currentNonce!)
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
}

