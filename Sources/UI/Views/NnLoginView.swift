//
//  NnLoginView.swift
//  
//
//  Created by Nikolai Nobadi on 5/29/23.
//

import SwiftUI

struct NnLoginView: View {
    @StateObject var dataModel: NnLoginDataModel
    @State private var isEditingTextFields = false
    
    let canShowResetPassword: Bool
    
    var body: some View {
        VStack {
            let emailDataModel = EmailLoginDataModel(
                canShowResetPassword: canShowResetPassword,
                emailLogin: dataModel.emailLogin(email:password:)
            )
            
            EmailLoginView(isEditingTextFields: $isEditingTextFields,
                           dataModel: emailDataModel)
            
            OtherLoginOptionsView(appleSignIn: dataModel.appleSignIn(tokenInfo:), googleSignIn: dataModel.googleSignIn)
                .onlyShow(when: !isEditingTextFields)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}


// MARK: - Preview
struct NnLoginView_Previews: PreviewProvider {
    static var previews: some View {
        NnLoginView(dataModel: dataModel, canShowResetPassword: true)
    }
    
    static var dataModel: NnLoginDataModel {
        NnLoginDataModel(auth: MockAuth())
    }
    
    class MockAuth: NnLoginAuth {
        func emailLogin(email: String, password: String) async throws { }
        func appleSignIn(tokenInfo: AppleTokenInfo) async throws { }
        func googleSignIn(tokenInfo: GoogleTokenInfo) async throws { }
    }
}
