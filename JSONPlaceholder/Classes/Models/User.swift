//
//  User.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import Foundation

/// User model.
struct User: Codable {
    
    /// The user id
    let id: Int
    /// The name of the user
    let name: String
    /// The user's email
    let email: String
    /// The user's phone number
    let phone: String
    /// The url of the user's website
    let website: URL
}
