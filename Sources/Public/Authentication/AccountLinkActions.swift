//
//  AccountLinkActions.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import Foundation

public protocol AccountLinkActions {
    func emailAccountLink(email: String, password: String) async throws
    func appleAccountLink(tokenInfo: AppleTokenInfo) async throws
    func googleAccountLink(tokenInfo: GoogleTokenInfo) async throws
}
