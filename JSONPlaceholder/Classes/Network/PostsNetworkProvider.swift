//
//  PostsNetworkProvider.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import Foundation
import Combine

/// Network provider for getting posts.
final class PostsNetworkProvider: NetworkProvider {
    
    // MARK: - Public Functions
    
    func getAllPosts() -> AnyPublisher<[Post], Error> {
        return dataTask(withEndpoint: "/posts")
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
