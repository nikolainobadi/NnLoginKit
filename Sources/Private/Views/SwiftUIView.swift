//
//  AccountLinkView.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import SwiftUI

struct AccountLinkView: View {
    @Binding var isLoading: Bool
    @StateObject var dataModel: AccountLinkDataModel
    
    let sectionTitle: String
    let linkButtonTint: Color
    
    var body: some View {
        Section(sectionTitle) {
            ForEach(dataModel.accountLinkTypes) { linkType in
                AccountLinkRow(canUnlink: dataModel.canUnlink, linkType: linkType) {
                    NoLoadingAsyncTryButton(action: { try await dataModel.performLinkAction(for: linkType) }) {
                        Text(linkType.email == nil ? "Link" : "Unlink")
                            .underline()
                            .foregroundColor(linkButtonTint)
                    }
                }
            }
        }
        .withSignUpTextFieldsAlert(isShowing: $dataModel.showingEmailSignUp,
                                   email: $dataModel.email,
                                   password: $dataModel.password,
                                   confirm: $dataModel.confirm,
                                   action: dataModel.performEmailSignUpAction)
        .withErrorHandling()
        .bindBool(viewBool: $isLoading, publishedBool: $dataModel.isLoading)
        .onAppear {
            dataModel.loadData()
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
            Group {
                AccountLinkView(isLoading: .constant(false), dataModel: dataModel, sectionTitle: "Sign-in Methods", linkButtonTint: .blue)
            }
        }
    }
    
    static var dataModel: AccountLinkDataModel {
        AccountLinkDataModel(auth: MockAuth(), setAuthenticationStatus: { _ in })
    }
    
    class MockAuth: NnAccountLinkAuth {
        func unlink(fromProvider: String) async throws { }
        func loadAvailableAccountLinkTypes() -> Set<AccountLinkType> {
            [.email(nil, { _ in }),
             .apple(nil, { _ in }),
             .google(nil, { _ in })]
        }
    }
}
