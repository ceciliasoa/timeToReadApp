//
//  APIError.swift
//  timeToReadApp
//
//  Created by Cecilia Soares on 09/02/21.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case couldNotDecode
    case failedRequest
    case unknowError (statuscode: Int)
}
