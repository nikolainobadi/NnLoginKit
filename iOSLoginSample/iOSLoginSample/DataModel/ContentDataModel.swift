//
//  ContentDataModel.swift
//  iOSLoginSample
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import Foundation

final class ContentDataModel: ObservableObject {
    @Published var userId = ""
    
    var isLoggedIn: Bool { userId != "" }
    
    init(userIdPublisher: Published<String>.Publisher) {
        userIdPublisher.assign(to: &$userId)
    }
}
