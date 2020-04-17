//
//  NetworkError.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case statusCode
    case invalidURL
    case notFound
}
