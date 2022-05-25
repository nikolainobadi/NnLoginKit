//
//  Validator.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import Foundation

public final class Validator {
    private init() { }
    
    public static func validate(_ text: String, with rules: [Rule]) -> String {
        guard text != "" else { return "" }
        
        return rules.compactMap({ $0.check(text) }).first ?? ""
    }
}

public struct Rule {
    
    let check: (String) -> String?
    
    public static let validEmail = Rule(check: {
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? nil : "Invalid email format"
    })
    
    public static let validPassword = Rule {
        $0.count >= 6 ? "" : "Password too short"
    }
    
    public static let validUsername = Rule {
        $0.count >= 4 ? "" : "Name too short"
    }
}
