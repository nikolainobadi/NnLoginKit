//
//  AccountLinkView.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import SwiftUI

struct AccountLinkView: View {
    @State var dataModel: AccountLinkDataModel
    
    let sectionTitle: String
    
    var body: some View {
        Section(sectionTitle) {
            AccountLinkRow(canUnlink: true, linkType: dataModel.passwordLinkType) {
                AsyncTryButton(action: dataModel.showEmailLogin) {
                    Text(dataModel.passwordEmail == nil ? "Link" : "Unlink")
                        .underline()
                }
            }
            
            AccountLinkRow(canUnlink: true, linkType: dataModel.appleLinkType) {
                AsyncTryButton(action: dataModel.appleAccountLink) {
                    Text(dataModel.appleEmail == nil ? "Link" : "Unlink")
                        .underline()
                }
            }
            
            AccountLinkRow(canUnlink: true, linkType: dataModel.googleLinkType) {
                AsyncTryButton(action: dataModel.googleAccountLink) {
                    Text(dataModel.googleEmail == nil ? "Link" : "Unlink")
                        .underline()
                }
            }
        }
        .sheet(isPresented: $dataModel.showingEmailView) {
            Text("This should be email sign-up view")
        }
    }
}

// MARK: - AccountLinkRow
fileprivate struct
AccountLinkRow<LinkButton: View>: View {
    let canUnlink: Bool
    let linkButton: LinkButton
    let linkType: AccountLinkType
    
    private var showButton: Bool { linkType.email == nil || canUnlink }
    
    init(canUnlink: Bool, linkType: AccountLinkType, @ViewBuilder linkButton: () -> LinkButton) {
        self.canUnlink = canUnlink
        self.linkType = linkType
        self.linkButton = linkButton()
    }
    
    var body: some View {
        HStack {
            linkType.image
                .font(.title) // only for email linkType
                .frame(width: getWidthPercent(10), height: getWidthPercent(10))
            
            VStack(alignment: .leading) {
                Text(linkType.title)
                
                if let email = linkType.email {
                    Text(email)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            linkButton
                .onlyShow(when: showButton)
        }
    }
}


// MARK: - Preview
struct AccountLinkView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            AccountLinkView(dataModel: dataModel, sectionTitle: "Sign-in Methods")
        }
    }
    
    static var dataModel: AccountLinkDataModel {
        AccountLinkDataModel()
    }
}

enum AccountLinkType {
    case email(String?)
    case apple(String?)
    case google(String?)
    
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

final class AccountLinkDataModel: ObservableObject {
    @Published var showingEmailView = false
}

extension AccountLinkDataModel {
    var passwordEmail: String? { "tester@gmail.com" }
    var appleEmail: String? { nil }
    var googleEmail: String? { nil }
    var passwordLinkType: AccountLinkType {
        return .email(passwordEmail)
    }
    
    var appleLinkType: AccountLinkType {
        return .apple(appleEmail)
    }
    
    var googleLinkType: AccountLinkType {
        return .google(googleEmail)
    }
    
    var accountLinkTypes: [AccountLinkType] {
        return [.email(passwordEmail), .apple(appleEmail), .google(googleEmail)]
    }
    
    func showEmailLogin() async throws {
        guard passwordEmail == nil else { return try await unlinkAccount() }
        
        await MainActor.run(body: {
            showingEmailView = true
        })
    }
    
    func appleAccountLink() async throws {
        
    }
    
    func googleAccountLink() async throws {
        
    }
    
    func unlinkAccount() async throws {
        
    }
}

private extension AccountLinkDataModel {
    
    
    
}
