//
//  AccountLinkActions.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import Foundation

/// `NnAccountLinkAuth` is a public protocol that defines methods related to linking and unlinking accounts.
/// It is designed to work with Firebase Authentication and uses provider IDs for account linking/unlinking.
/// The provider IDs are as follows:
/// - For Email/Password: "password"
/// - For Google: "google.com"
/// - For Apple: "apple.com"
public protocol NnAccountLinkAuth {
    /// Asynchronously unlinks an account from the specified provider.
    ///
    /// - Parameter fromProvider: The provider from which the account should be unlinked. This should be
    ///   one of the provider IDs mentioned above.
    ///
    /// - Throws: An error if the unlinking process fails.
    func unlink(fromProvider: String) async throws
    
    /// Loads the set of available account link types.
    ///
    /// - Returns: A `Set` of `AccountLinkType` objects representing the available types of accounts that can be linked.
    func loadAvailableAccountLinkTypes() -> Set<AccountLinkType>
}
