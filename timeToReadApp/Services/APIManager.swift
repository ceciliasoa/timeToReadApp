//
//  APIManager.swift
//  timeToReadApp
//
//  Created by Cecilia Soares on 09/02/21.
//

import Foundation
import UIKit

struct ApiManager: Codable {
    
    func booksApi(searchItens: String, completion: @escaping (Result< [Book], ApiError>) -> Void) {
        
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(searchItens)"
//        let url = "https://www.googleapis.com/books/v1/volumes?q=harry+potter+e+a+pedra+filosofal"
        guard let getUrl = URL(string: url) else {
            completion(.failure(ApiError.invalidUrl))
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let getBookTask = session.dataTask(with: getUrl) { (data, response, error) in
            
            if error != nil {
                completion(.failure(ApiError.couldNotDecode))
            }
            
            guard let response = response as? HTTPURLResponse else {return}
            print(response)
            print(response.statusCode)
            switch response.statusCode {
            case 200:
                if let data = data {
                    do {
                       let response = try JSONDecoder().decode(Response.self, from: data)
                         completion(.success(response.items))
                    } catch {
                        print(error)
                       completion(.failure(ApiError.couldNotDecode))
                    }
                    
                }
            default:
                completion(.failure(ApiError.failedRequest))
            }
        }
        getBookTask.resume()
    }
}
