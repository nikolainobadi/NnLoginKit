//
//  LoginNetworker.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import Foundation
import NnLoginKit

final class LoginNetworker {
    private let store: UserIdStore
    
    init(store: UserIdStore) {
        self.store = store
    }
}


// MARK: - Auth
extension LoginNetworker: NnLoginAuth {
    @MainActor private func setUserId(_ uid: String) { store.setUserId(uid) }
    
    func guestLogin() async throws {
        await setUserId("Guest UID")
    }
    
    func guestSignIn() async throws {
        
    }
    
    func emailLogin(email: String, password: String) async throws {
        
    }
    
    func appleSignIn(tokenInfo: NnLoginKit.AppleTokenInfo) async throws {
        
    }
    
    func googleSignIn(tokenInfo: NnLoginKit.GoogleTokenInfo) async throws {
        
    }
}


// MARK: - Dependencies
protocol UserIdStore {
    func setUserId(_ uid: String)
}
