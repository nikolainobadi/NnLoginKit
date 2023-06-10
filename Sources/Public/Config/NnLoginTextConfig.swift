//
//  NnLoginTextConfig.swift
//  
//
//  Created by Nikolai Nobadi on 5/31/23.
//

/// `NnLoginTextConfig` is a struct that defines the text displayed on the login page. This text appears
/// alongside a "Get Started" button, which allows users to begin using the app and triggers anonymous sign-in.
/// An additional button at the bottom of the view, referred to as the "account button", allows users with existing
/// accounts to log in with various methods, such as email/password, Apple ID, and Google account.
public struct NnLoginTextConfig {
    /// The title of the app. This is displayed prominently on the login page.
    let appTitle: String
    
    /// The tagline of the app. This is a short, catchy phrase that describes the app.
    let tagline: String
    
    /// The sub-tagline of the app. This can be used to provide additional information or detail about the app.
    let subTagline: String
    
    /// Initializes a new `NnLoginTextConfig` instance with the specified `appTitle`, `tagline`, and `subTagline`.
    ///
    /// - Parameters:
    ///   - appTitle: The title of the app.
    ///   - tagline: The tagline of the app.
    ///   - subTagline: The sub-tagline of the app.
    public init(appTitle: String, tagline: String, subTagline: String) {
        self.appTitle = appTitle
        self.tagline = tagline
        self.subTagline = subTagline
    }
}
