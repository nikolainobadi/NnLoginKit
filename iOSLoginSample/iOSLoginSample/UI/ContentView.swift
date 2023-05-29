//
//  ContentView.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI

struct ContentView: View {
    @State var userId = ""
    
    var body: some View {
        if userId.isEmpty {
            LoginComposer.makeLoginView()
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
