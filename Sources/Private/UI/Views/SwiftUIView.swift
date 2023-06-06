//
//  AccountLinkView.swift
//  
//
//  Created by Nikolai Nobadi on 6/5/23.
//

import SwiftUI

struct AccountLinkView: View {
    @StateObject var dataModel: AccountLinkDataModel
    
    let sectionTitle: String
    
    var body: some View {
        Section(sectionTitle) {
            ForEach(dataModel.accountLinkTypes) { linkType in
                AccountLinkRow(canUnlink: dataModel.canUnlink, linkType: linkType) {
                    AsyncTryButton(action: { try await dataModel.performLinkAction(for: linkType) }) {
                        Text(linkType.email == nil ? "Link" : "Unlink")
                            .underline()
                    }
                }
            }
        }
        .onAppear {
            dataModel.loadData()
        }
        .alert("", isPresented: $dataModel.showingEmailSignUp, actions: {
            TextField("email", text: $dataModel.email)
            SecureField("password", text: $dataModel.password)
            SecureField("confirm password", text: $dataModel.confirm)
            AsyncTryButton(action: dataModel.performEmailSignUpAction, role: .destructive) {
                Text("Sign up")
            }
        }, message: {
            Text("Here is a message")
        })
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
        .withLoadingView()
        .withErrorHandling()
    }
    
    static var dataModel: AccountLinkDataModel {
        AccountLinkDataModel(auth: MockAuth())
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

struct TextFieldAlert<Presenting>: View where Presenting: View {
    @Binding var isShowing: Bool
    @Binding var text: String
    let presenting: Presenting
    let title: String

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(isShowing)
                VStack {
                    Text(self.title)
                    TextField(self.title, text: self.$text)
                    Divider()
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.isShowing.toggle()
                            }
                        }) {
                            Text("Dismiss")
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .frame(
                    width: deviceSize.size.width*0.7,
                    height: deviceSize.size.height*0.7
                )
                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}

extension View {
    func textFieldAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        title: String) -> some View {
        TextFieldAlert(isShowing: isShowing,
                       text: text,
                       presenting: self,
                       title: title)
    }
}
