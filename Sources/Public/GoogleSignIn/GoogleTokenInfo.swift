//
//  GoogleTokenInfo.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

/// `GoogleTokenInfo` is a typealias for a tuple containing information related to a Google ID token and access token.
///
/// The `idTokenString` is a string representation of the ID token that is provided by Google after a successful authentication.
/// The `accessTokenString` is a string representation of the access token that can be used to authenticate API calls to Google services.
public typealias GoogleTokenInfo = (idTokenString: String, accessTokenString: String)

