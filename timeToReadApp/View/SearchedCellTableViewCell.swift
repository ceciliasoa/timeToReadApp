//
//  SearchedCellTableViewCell.swift
//  timeToReadApp
//
//  Created by Cecilia Soares on 09/02/21.
// swiftlint:disable private_outlet

import UIKit

class SearchedCellTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var pages: UILabel!
    
    static let xibName = "searchedCell"
    static let identifier = "SearchedCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        title.tintColor = .textColor
        author.tintColor = .textColor
        pages.tintColor = .textColor
    }

    func configure(with book: BookModel) {
        title.text = book.title
        author.text = book.author
        pages.text = String(book.pages ?? 0)
    }

}
