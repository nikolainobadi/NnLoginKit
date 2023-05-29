//
//  iOSLoginSampleApp.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import SwiftUI

@main
struct iOSLoginSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(dataModel: ContentDataModel(userIdPublisher: SharedUserIdStorage.shared.$userId))
        }
    }
}
