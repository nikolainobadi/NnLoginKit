//
//  InAppView.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI
import NnSwiftUIDesignHelpers

struct InAppView: View {
    @Binding var userId: String
    var body: some View {
        VStack {
            VStack(spacing: getHeightPercent(10)) {
                Text("You are now logged into your app!")
                    .font(.title)
                    
                Text("UserId: \(userId)")
                    .font(.headline)
            }.multilineTextAlignment(.center)
            
            
            Button(action: { userId = "" }) {
                Text("Logout")
                    .font(.headline)
            }.buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .secondarySystemBackground))
    }
}
