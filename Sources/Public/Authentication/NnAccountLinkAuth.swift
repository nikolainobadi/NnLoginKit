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
/// The `loadAvailableAccountLinkTypes()` method should return a set of `NnAccountLinkType` instances
/// representing the types of accounts the developer would like to display in the `AccountLinkView`.
/// For example, if the developer only wants to allow Apple and Google sign-in methods,
/// the method should only return the `.apple` and `.google` cases of `NnAccountLinkType`.
///
/// It's important to note that the `loadAvailableAccountLinkTypes()` should also provide the
/// appropriate associated values (i.e., email and action) with each `NnAccountLinkType` case.
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
///     func loadAvailableAccountLinkTypes() -> Set<NnAccountLinkType> {
///         // only return .apple and .google to allow only these sign-in methods
///
///         let appleLinkAction: NnAccountLinkType.AppleLinkAction = { tokenInfo in
///             // code to link with Apple
///         }
///
///         let googleLinkAction: NnAccountLinkType.GoogleLinkAction = { tokenInfo in
///             // code to link with Google
///         }
///
///         let currentUser = Auth.auth().currentUser // requires FirebaseAuth
///
///         let googleEmail = currentUser?.providerData.first(where: { $0.providerID == "google.com" })?.email
///
///         let appleEmail =  currentUser?.providerData.first(where: { $0.providerID == "apple.com" })?.email
///
///         return [
///             .apple(appleEmail, appleLinkAction),
///             .google(googleEmail, googleLinkAction)
///         ]
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
    /// - Returns: A `Set` of `NnAccountLinkType` objects representing the types of accounts that can be linked.
    func loadAvailableAccountLinkTypes() -> Set<NnAccountLinkType>
}
