//
//  NetworkProvider.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import Foundation
import Combine

/// Base class for the network provider.
class NetworkProvider {
    
    private struct Constant {
        static let baseURL = "https://jsonplaceholder.typicode.com"
    }
    
    // MARK: - Public Functions
    
    /// Get a publisher for making a request to the given endpoint.
    /// - Parameter endpoint: The endpoint to use.
    /// - Returns: An `AnyPublisher` with the data for the request or an error.
    final func dataTask(withEndpoint endpoint: String) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: "\(Constant.baseURL)\(endpoint)") else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.global())
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        throw NetworkError.statusCode
                }
                return data
        }
        .eraseToAnyPublisher()
    }
}
