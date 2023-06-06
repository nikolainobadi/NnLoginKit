//
//  AccountLinkType.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import SwiftUI

public enum AccountLinkType: Hashable {
    case email(String?)
    case apple(String?)
    case google(String?)
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
        case .email(let email):
            return email
        case .apple(let email):
            return email
        case .google(let email):
            return email
        }
    }
}
