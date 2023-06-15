//
//  NnAccountLinkType.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import SwiftUI

/// `NnAccountLinkType` is a public enum that describes the type of account link a user can create.
/// Each case corresponds to a different type of account link: email, Apple, and Google.
///
/// Each case has associated values:
/// - An optional email address, derived from the email of the provider ID in Firebase.
///   For example, if the user has linked their account with Google, then the Google email
///   should be passed in as the email associated value.
/// - A closure that performs the link action and returns asynchronously.
public enum NnAccountLinkType {
    public typealias Email = String
    public typealias EmailAndPassword = (String, String)
    public typealias EmailPasswordLinkAction = (EmailAndPassword) async throws -> Void
    public typealias AppleLinkAction = (AppleTokenInfo) async throws -> Void
    public typealias GoogleLinkAction = (GoogleTokenInfo) async throws -> Void
    
    case email(Email?, EmailPasswordLinkAction)
    case apple(Email?, AppleLinkAction)
    case google(Email?, GoogleLinkAction)
}

// MARK: - Identifiable
extension NnAccountLinkType: Identifiable {
    /// Unique identifier for each case in the `AccountLinkType` enum.
    public var id: Int {
        switch self {
        case .email:
            return 0
        case .apple:
            return 1
        case .google:
            return 2
        }
    }
}

// MARK: - Hashable
extension NnAccountLinkType: Hashable {
    /// Provides the hash value for an `AccountLinkType` enum instance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    /// Checks the equality between two `AccountLinkType` enum instances.
    public static func == (lhs: NnAccountLinkType, rhs: NnAccountLinkType) -> Bool {
        lhs.id == rhs.id
    }
}

extension NnAccountLinkType {
    /// Provides the title for each case in the `AccountLinkType` enum.
    var title: String {
        switch self {
        case .email:
            return "Email Address"
        case .apple:
            return "Apple ID"
        case .google:
            return "Google Account"
        }
    }
    
    /// Provides the image for each case in the `AccountLinkType` enum.
    var image: some View {
        Group {
            switch self {
            case .email:
                Image(systemName: "envelope")
            case .apple:
                Image("appleIcon", bundle: .module)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .google:
                Image("Google", bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    /// Retrieves the email address associated with the account, if one exists.
    var email: String? {
        switch self {
        case .email(let email, _):
            return email
        case .apple(let email, _):
            return email
        case .google(let email, _):
            return email
        }
    }
    
    /// Provides the provider ID associated with each account type.
    var providerId: String {
        switch self {
        case .email:
            return "password"
        case .apple:
            return "apple.com"
        case .google:
            return "google.com"
        }
    }
}
