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
///
/// ## Example usage:
/// Here is how you might implement a class that conforms to `NnAccountLinkAuth`:
///
/// ```swift
/// class MyAuth: NnAccountLinkAuth {
///     func unlink(fromProvider: String) async throws {
///         // code to unlink from the specified provider
///     }
///
///     func loadAvailableAccountLinkTypes() -> Set<AccountLinkType> {
///         // code to load the available account link types
///     }
/// }
///
/// ```
///
/// Remember that the actual implementation of `unlink(fromProvider:)` and `loadAvailableAccountLinkTypes()`
/// will depend on your specific authentication setup.
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
