//
//  ContentView.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI
import NnLoginKit

struct ContentView: View {
    @StateObject var dataModel: ContentDataModel
    
    var body: some View {
        if dataModel.isLoggedIn {
            InAppView()
        } else {
            LoginComposer.makeLoginView()
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataModel: ContentDataModel(userIdPublisher: SharedUserIdStorage.shared.$userId))
    }
}
