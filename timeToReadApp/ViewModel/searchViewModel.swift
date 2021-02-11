//
//  searchViewModel.swift
//  timeToReadApp
//
//  Created by Cecilia Soares on 08/02/21.
//

import Foundation
protocol SaveBookDelegate: class {
    func reloadData()
}
class SearchViewModel {
    weak var delegate: SaveBookDelegate?

    func searchItens (searchItens: String) {
        ApiManager().booksApi(searchItens: searchItens) { (result) in
            switch result {
            case .success(let book):
                print(book)
                guard let title = book[0].volumeInfo.title else {fatalError("error")}
                guard let page = book[0].volumeInfo.pageCount else {fatalError("Error")}
                guard let author = book[0].volumeInfo.authors[0] else {fatalError("Error")}
                guard let description = book[0].volumeInfo.description else {fatalError("Error")}
                
                print(page, title, author, description)
                
                let bookRepository = BookRepository()
                let book = BookModel(title: title,
                                     author: author,
                                     pages: page,
                                     status: nil,
                                     cover: nil,
                                     readpages: nil,
                                     percentage: nil,
                                     synopsis: description)
                bookRepository.create(book: book)
                self.delegate?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
}
