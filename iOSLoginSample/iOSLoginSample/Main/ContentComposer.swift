//
//  ContentComposer.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import SwiftUI

enum ContentComposer {
    static func makeContentView() -> some View {
        ContentView(dataModel: ContentDataModel(userIdPublisher: SharedUserIdStorage.shared.$userId))
    }
}
