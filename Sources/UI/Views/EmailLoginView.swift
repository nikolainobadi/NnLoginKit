//
//  EmailLoginView.swift
//  
//
//  Created by Nikolai Nobadi on 5/27/23.
//

import SwiftUI

struct EmailLoginView: View {
    @State var dataModel: EmailLoginDataModel
    @FocusState var selectedField: LoginSelectedField?
    
    private func tryLogin() async throws {
        selectedField = nil
        try await dataModel.tryLogin()
    }
    
    var body: some View {
        VStack {
            if let errorMessage = dataModel.loginErrorMessage {
                Text(errorMessage)
                    .bold()
                    .foregroundColor(.red)
            }
        }
    }
}


// MARK: - Preview
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        EmailLoginView(dataModel: dataModel)
    }
    
    static var dataModel: EmailLoginDataModel {
        EmailLoginDataModel(showResetPassword: { }, emailLogin: { _, _ in })
    }
}
