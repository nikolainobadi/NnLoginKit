//
//  ContentView.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var userId = ""
    
    var body: some View {
        if userId.isEmpty {
            LoginComposer.makeLoginView(login: { userId = $0 })
        } else {
            InAppView(userId: $userId)
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
