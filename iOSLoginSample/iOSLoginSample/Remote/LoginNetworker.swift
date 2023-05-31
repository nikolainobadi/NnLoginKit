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
        await setUserId("Guest userId")
    }
    
    func emailLogin(email: String, password: String) async throws {
        await setUserId("emailUserId")
    }
    
    func appleSignIn(tokenInfo: NnLoginKit.AppleTokenInfo) async throws {
        await setUserId("appleUserId")
    }
    
    func googleSignIn(tokenInfo: NnLoginKit.GoogleTokenInfo) async throws {
        await setUserId("googleUserId")
    }
    
    func sendResetEmail(email: String) async throws {
        print("email sent to \(email)")
    }
}


// MARK: - Dependencies
protocol UserIdStore {
    func setUserId(_ uid: String)
}
