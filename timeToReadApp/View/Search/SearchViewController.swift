//
//  SearchViewController.swift
//  timeToReadApp
//
//  Created by Cecilia Soares on 08/02/21.
//
// swiftlint:disable line_length force_cast cyclomatic_complexity

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
    var viewModel = SearchViewModel()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        view = searchView
        viewModel.delegate = self
    }
    
    // MARK: - Selectors
    
    @objc func handleShowSearchBar() {
        searchBar.becomeFirstResponder()
        searchBar.tintColor = .disabledColor
        search(shouldShow: true)
    }
    func transaction() {
        let bookController = UINavigationController(rootViewController: BookDescriptionViewController())
        bookController.modalPresentationStyle = .fullScreen
        bookController.isNavigationBarHidden = true
        bookController.modalTransitionStyle = .crossDissolve
        present(bookController, animated: true, completion: nil)
    }
    
    // MARK: - Helper Functions
    func reloadData() {
        DispatchQueue.main.async {
            self.searchView.tableView.reloadData()
        }
    }
    func setupUI() {
        searchBar.sizeToFit()
        searchBar.tintColor = .disabledColor
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
        searchBar.placeholder = "Busque por um livro"
        searchBar.tintColor = .actionColor
        navigationItem.titleView = searchBar
    }
    func loadData(type: String, indexPath: Int) -> String {
        switch type {
        case "title":
            if self.allBooks.readAll()[indexPath].value(forKey: "title") != nil {
                guard let title = allBooks.readAll()[indexPath].value(forKey: "title") as? String else { return "Error" }
                return title
            }
        case "author":
            if self.allBooks.readAll()[indexPath].value(forKey: "author") != nil {
                guard let author = allBooks.readAll()[indexPath].value(forKey: "author") as? String else { return "Error" }
                return author
            }
        case "pages":
            if self.allBooks.readAll()[indexPath].value(forKey: "pages") != nil {
                guard let pages = allBooks.readAll()[indexPath].value(forKey: "pages") as? Int else { return "Error"}
                return String(pages)
            }
        case "synopsis":
            if self.allBooks.readAll()[indexPath].value(forKey: "synopsis") != nil {
                guard let synopsis = allBooks.readAll()[indexPath].value(forKey: "synopsis") as? String else { return "Error"}
                print(synopsis)
                return synopsis
            }
        default:
            return "Error"
        }
        return "error"
    }
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allBooks.readAll().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedCell", for: indexPath) as! SearchedCellTableViewCell
        cell.title.text = loadData(type: "title", indexPath: indexPath.row)
        cell.author.text = loadData(type: "author", indexPath: indexPath.row)
        cell.pages.text = loadData(type: "pages", indexPath: indexPath.row)
    return cell
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let bookController = UINavigationController(rootViewController: BookDescriptionViewController())
    let bookController = BookDescriptionViewController()
    bookController.bookView.title.text = loadData(type: "title", indexPath: indexPath.row)
    bookController.bookView.author.text = loadData(type: "author", indexPath: indexPath.row)
    bookController.bookView.pages.text = loadData(type: "pages", indexPath: indexPath.row)
    print(loadData(type: "synopsis", indexPath: indexPath.row))
    bookController.bookView.synopsisText.text = loadData(type: "synopsis", indexPath: indexPath.row)
    
        //        bookController.modalTransitionStyle = .
        navigationController?.pushViewController(bookController, animated: true)
    //        present(bookController, animated: true, completion: nil)
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
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did end..")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        search(shouldShow: false)
//        self.searchView.tableView.reloadData()
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is \(searchText)")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searched = searchBar.text else { fatalError("error") }
        let searchReplace = searched.replacingOccurrences(of: " ", with: "+")
        print(searchReplace)
        viewModel.searchItens(searchItens: searchReplace)
        //        self.searchView.tableView.reloadData()
    }
    
}
