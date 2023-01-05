//
//  LoginNetworker.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import Foundation
import NnLoginKit // can remove by replacing parameters in emailSignUp with same as emailLogin

final class LoginNetworker {
    private let store: UserIdStore
    
    init(store: UserIdStore) {
        self.store = store
    }
}


// MARK: - Login Auth Actions
extension LoginNetworker {
    func guestLogin() async throws {
        store.setUserId("Guest UID")
    }
    
    // importing NnLoginKit is NOT necessary with this type of parameter
    func emailLogin(_ info: ((email: String, password: String))) async throws {
        print("Logging in with email: \(info.email), password: \(info.password)")
        store.setUserId("Login UID")
    }
    
    func emailSignUp(_ info: (EmailLoginInfo)) async throws {
        print("Signing Up with email: \(info.email), password: \(info.password)")
        store.setUserId("SignUp UID")
    }
}


// MARK: - Dependencies
protocol UserIdStore {
    func setUserId(_ uid: String)
}
