//
//  AccountLinkActions.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import Foundation

public protocol NnAccountLinkAuth {
    func emailAccountLink(email: String, password: String) async throws
    func appleAccountLink(tokenInfo: AppleTokenInfo) async throws
    func googleAccountLink(tokenInfo: GoogleTokenInfo) async throws
    func unlinkPasswordEmail() async throws
    func unlinkAppleId() async throws
    func unlinkGoogleAccount() async throws
}
