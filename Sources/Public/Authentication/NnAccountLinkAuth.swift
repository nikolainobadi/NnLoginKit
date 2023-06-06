//
//  AccountLinkActions.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import Foundation

public protocol NnAccountLinkAuth {
    func unlink(fromProvider: String) async throws
    func loadAvailableAccountLinkTypes() -> Set<AccountLinkType>
}
