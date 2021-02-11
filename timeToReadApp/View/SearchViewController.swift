//
//  SearchViewController.swift
//  timeToReadApp
//
//  Created by Cecilia Soares on 08/02/21.
//
// swiftlint:disable line_length force_cast

import UIKit
import CoreData
//protocol SaveBookDelegate: class {
//    func reloadData()
//}
class SearchViewController: UIViewController, SaveBookDelegate {
    
    // MARK: - Elements
    let searchBar = UISearchBar()
    var shouldShowSearchResults = false
    let searchView = SearchView()
    var allBooks = BookRepository()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        view = searchView
    }
    
    // MARK: - Selectors
    
    @objc func handleShowSearchBar() {
        searchBar.becomeFirstResponder()
        search(shouldShow: true)
    }
    
    // MARK: - Helper Functions
    func reloadData() {
        self.searchView.tableView.reloadData()
    }
    func setupUI() {
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationController?.navigationBar.barTintColor = .backgroundColor
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        showSearchBarButton(shouldShow: true)
    }
    func setupTableView() {
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.tableView.register(UINib.init(nibName: "searchedCell", bundle: nil), forCellReuseIdentifier: "SearchedCell")
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            search(shouldShow: shouldShow)
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !true)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = searchBar
    }
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allBooks.readAll().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedCell", for: indexPath) as! SearchedCellTableViewCell

        if self.allBooks.readAll()[indexPath.row].value(forKey: "title") != nil,
           self.allBooks.readAll()[indexPath.row].value(forKey: "author") != nil,
           self.allBooks.readAll()[indexPath.row].value(forKey: "pages") != nil {
            let title = allBooks.readAll()[indexPath.row].value(forKey: "title") as? String
            let author = allBooks.readAll()[indexPath.row].value(forKey: "author") as? String
            let pages = allBooks.readAll()[indexPath.row].value(forKey: "pages") as? Int
            cell.title.text = title
            cell.author.text = author
            guard let page = pages else {return cell}
            cell.pages.text = String(page)
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var readbooks = allBooks.readAll()
        print(readbooks)
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let bookToRemove = readbooks[indexPath.row]
            self.allBooks.remove(book: bookToRemove)
            readbooks.remove(at: indexPath.row)
            self.searchView.tableView.reloadData()

        }
        let deleted = UISwipeActionsConfiguration(actions: [action])
        return deleted

    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did begin..")
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did end..")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
        self.searchView.tableView.reloadData()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is \(searchText)")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searched = searchBar.text else { fatalError("error") }
        let searchReplace = searched.replacingOccurrences(of: " ", with: "+")
        print(searchReplace)
        let viewModel = SearchViewModel()
        viewModel.searchItens(searchItens: searchReplace)
        self.searchView.tableView.reloadData()
    }

}
