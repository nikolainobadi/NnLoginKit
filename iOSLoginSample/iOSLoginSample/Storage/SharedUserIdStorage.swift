//
//  SharedUserIdStorage.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import Foundation

final class SharedUserIdStorage {
    @Published var userId = ""
    
    static let shared = SharedUserIdStorage()
    
    private init() { }
}


// MARK: - Store
extension SharedUserIdStorage: UserIdStore {
    func setUserId(_ uid: String) {
        userId = uid
    }
}
