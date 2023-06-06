//
//  AccountLinkType.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import SwiftUI

public enum AccountLinkType {
    public typealias Email = String
    public typealias ShowEmailAction = () -> Void
    public typealias AppleLinkAction = (AppleTokenInfo) async throws -> Void
    public typealias GoogleLinkAction = (GoogleTokenInfo) async throws -> Void
    
    case email(Email?, ShowEmailAction)
    case apple(Email?, AppleLinkAction)
    case google(Email?, GoogleLinkAction)
}


// MARK: - Identifiable
extension AccountLinkType: Identifiable {
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
extension AccountLinkType: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: AccountLinkType, rhs: AccountLinkType) -> Bool {
        lhs.id == rhs.id
    }
}

extension AccountLinkType {
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
