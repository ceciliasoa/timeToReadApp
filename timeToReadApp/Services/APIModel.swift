//
//  APIModel.swift
//  timeToReadApp
//
//  Created by Cecilia Soares on 09/02/21.
//

import Foundation
/*
struct Book: Identifiable, Decodable, Hashable{
    var id: String
    
    struct items: Decodable, Identifiable, Hashable {
        var id: String
        var pageCount:[String:String]
    }
  
}
 */

struct Response: Decodable {
    var items: [Book]
}

struct Book: Decodable {
    var volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    var title: String?
    var authors: [String?]
    var pageCount: Int?
    var description: String?

}
