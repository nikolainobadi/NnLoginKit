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
            ForEach(dataModel.accountLinkTypes, id: \.self) { linkType in
                AccountLinkRow(canUnlink: true, linkType: linkType) {
                    AsyncTryButton(action: { try await dataModel.performLinkAction(for: linkType) }) {
                        Text(linkType.email == nil ? "Link" : "Unlink")
                            .underline()
                    }
                }
            }
        }
        .sheet(isPresented: $dataModel.showingEmailView) {
            Text("This should be email sign-up view")
        }
    }
}


// MARK: - AccountLinkRow
fileprivate struct AccountLinkRow<LinkButton: View>: View {
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
        AccountLinkDataModel(auth: MockAuth())
    }
    
    class MockAuth: NnAccountLinkAuth {
        func emailAccountLink(email: String, password: String) async throws { }
        func appleAccountLink(tokenInfo: AppleTokenInfo) async throws { }
        func googleAccountLink(tokenInfo: GoogleTokenInfo) async throws { }
        func unlinkPasswordEmail() async throws { }
        func unlinkAppleId() async throws { }
        func unlinkGoogleAccount() async throws { }
    }
}
