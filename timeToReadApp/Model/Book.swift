//
//  Book.swift
//  timeToReadApp
//
//  Created by Cecilia Soares on 08/02/21.
//

import Foundation

class BookModel {
    var title: String?
    var author: String?
    var pages: Int?
    var status: String?
    var cover: String?
    var readpages: Int?
    var percentage: Int?
    var synopsis: String?
    init(title: String?,
         author: String?,
         pages: Int?,
         status: String?,
         cover: String?,
         readpages: Int?,
         percentage: Int?,
         synopsis: String?) {
        self.title = title
        self.author = author
        self.pages = pages
        self.status = status
        self.cover = cover
        self.readpages = readpages
        self.percentage = percentage
        self.synopsis = synopsis
    }
    static var bookSearched = [BookModel]()

//    static var cardsFromServer = [Card]()
    
}
