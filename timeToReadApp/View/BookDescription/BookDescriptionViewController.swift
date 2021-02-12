//
//  BookDescriptionViewController.swift
//  timeToReadApp
//
//  Created by Cecilia Soares on 11/02/21.
//
// swiftlint:disable line_length

import UIKit

class BookDescriptionViewController: UIViewController {
    let bookView = BookDescription()
    var allBooks = BookRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = bookView
        setupTableView()
        navigationController?.navigationBar.tintColor = .actionColor
    }

    func setupTableView() {
        bookView.descriptionBook.delegate = self
        bookView.descriptionBook.dataSource = self
    }
}
extension BookDescriptionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        
        //          seta que a label expanda até o maximo
        cell.textLabel?.numberOfLines = .max
        cell.textLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        cell.backgroundColor = .backgroundSecundary
        cell.selectionStyle = .none
        cell.textLabel?.text = bookView.synopsisText.text

        return cell
    }
}
