//
//  ResetPasswordDataModel.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/23.
//

import Foundation

final class ResetPasswordDataModel: ObservableObject {
    @Published var email = ""
    @Published var error: Error?
    
}

extension ResetPasswordDataModel {
    var disableButton: Bool { email.count < 6 || !email.contains("@") || !email.contains(".") }
    var message: String { "Enter your email address and a link will be sent allowing you to reset your password." }
    
    func resetPassword() { }
}
