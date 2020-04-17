//
//  UserNetworkProvider.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import Foundation
import Combine

/// Network provider for users
final class UserNetworkProvider: NetworkProvider {
    
    // MARK: - Public Functions
    
    func getUser(id: Int) -> AnyPublisher<User, Error> {
        return dataTask(withEndpoint: "/users/\(id)")
            .decode(type: User.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
