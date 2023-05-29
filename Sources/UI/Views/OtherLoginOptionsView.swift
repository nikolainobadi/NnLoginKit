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
            
            if let appleSignIn = appleSignIn {
                CustomAppleButton(appleSignIn: appleSignIn)
                    .frame(maxHeight: getHeightPercent(5))
            }
            
            if let googleSignIn = googleSignIn {
                CustomGoogleButton(googleSignIn: googleSignIn)
                    .buttonStyle(.bordered)
                    .padding(.vertical, getHeightPercent(1))
            }
        }
    }
}


// MARK: - Preview
struct OtherLoginOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OtherLoginOptionsView(appleSignIn: { _ in }, googleSignIn: { _ in })
    }
}
