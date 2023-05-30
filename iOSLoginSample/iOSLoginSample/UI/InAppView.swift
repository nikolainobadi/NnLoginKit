//
//  InAppView.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI

struct InAppView: View {
    @Binding var userId: String
    
    var body: some View {
        VStack {
            Text("You are now logged into your app!")
                .font(.title)
                .padding(.vertical)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Text("UserId: \(userId)")
                .font(.headline)
            
            Spacer()
            
            Button(action: { userId = "" }) {
                Text("Logout")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .secondarySystemBackground))
    }
}


// MARK: - Preview
struct InAppView_Previews: PreviewProvider {
    static var previews: some View {
        InAppView(userId: .constant("userId"))
    }
}
