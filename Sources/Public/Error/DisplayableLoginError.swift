//
//  DisplayableLoginError.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import Foundation

public protocol DisplayableLoginError {
    var title: String { get }
    var message: String { get }
}
