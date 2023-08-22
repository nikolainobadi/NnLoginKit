//
//  OtherLoginOptionsView.swift
//  
//
//  Created by Nikolai Nobadi on 5/29/23.
//

import SwiftUI

struct OtherLoginOptionsView: View {
    let appleSignIn: ((AppleTokenInfo) async throws -> Void)?
    let googleSignIn: ((GoogleTokenInfo?) async throws -> Void)?
    
    var body: some View {
        VStack {
            LabelledDivider(text: "Or")
                .padding(.vertical)
            
            VStack {
                if let appleSignIn = appleSignIn {
                    CustomAppleButton { tokenInfo in
                        if let tokenInfo = tokenInfo {
                            try await appleSignIn(tokenInfo)
                        }
                    }
                }

                if let googleSignIn = googleSignIn {
                    CustomGoogleButton(googleSignIn: googleSignIn)
                        .padding(.vertical, getHeightPercent(1))
                }
            }
            .padding()
        }
    }
}


// MARK: - Preview
struct OtherLoginOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OtherLoginOptionsView(appleSignIn: { _ in }, googleSignIn: { _ in })
    }
}
