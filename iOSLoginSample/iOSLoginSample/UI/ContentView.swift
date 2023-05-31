//
//  ContentView.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var store = UserIdStorage()
    
    var body: some View {
        if store.userId.isEmpty {
            LoginComposer.makeLoginView(store: store)
                
        } else {
            InAppView(userId: $store.userId)
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// MARK: - Dependencies
final class UserIdStorage: ObservableObject, UserIdStore {
    @Published var userId = ""
    
    func setUserId(_ uid: String) {
        self.userId = uid
    }
}
