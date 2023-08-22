//
//  CustomAppleButton.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI
import NnSwiftUIErrorHandling

struct CustomAppleButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    let appleSignIn: (AppleTokenInfo?) async throws -> Void
    
    private func signInAction() async throws {
        try await appleSignIn(AppleSignInCoordinator().createAppleTokenInfo())
    }
    
    var body: some View {
        NnAsyncTryButton(action: signInAction) {
            HStack {
                Image("appleIcon", bundle: .module)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(colorScheme == .light ? .white : .black)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                Text("Continue with Apple")
                    .font(.title3)
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(maxWidth: getWidthPercent(50), alignment: .leading)
            }
            .frame(maxWidth: .infinity)
        }
        .tint(.primary)
        .buttonStyle(.borderedProminent)
    }
}


// MARK: - Preview
struct CustomAppleButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomAppleButton(appleSignIn: { _ in })
            .padding()
    }
}
