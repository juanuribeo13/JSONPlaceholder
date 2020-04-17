//
//  Post.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import Foundation

/// Post model.
struct Post: Codable {
    
    /// The post id
    let id: Int
    /// The post title
    let title: String
    /// The post content
    let body: String
    /// The id of the user that created the post
    let userId: Int
}

// MARK: - Equatable

extension Post: Equatable {
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Hashable

extension Post: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
