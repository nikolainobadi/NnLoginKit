//
//  UserSessionInfo.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

public struct UserSessionInfo: Equatable {
    
    public let userId: String
    public let isNewUser: Bool
    public let isGuest: Bool
    
    public init(userId: String, isGuest: Bool, isNewUser: Bool) {
        self.userId = userId
        self.isNewUser = isNewUser
        self.isGuest = isGuest
    }
}
