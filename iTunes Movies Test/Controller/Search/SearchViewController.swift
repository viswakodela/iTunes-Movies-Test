//
//  SearchViewController.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/26/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    // MARK:- Init
    init(searchResultsUpdater: SearchResultsUpdater) {
        self.searchResultsUpdater = searchResultsUpdater
        super.init(style: .plain)
        self.searchResultsUpdater.delegate = self
    }
    
    // MARK:- Properties
    let searchResultsUpdater: SearchResultsUpdater
    var searchController: UISearchController!
    var emptyArray = [String]()
    var tableHeaderHeight: CGFloat = 150
    var timer: Timer?
    var searchText = ""
    var isPaginating = false
    var movies = [Movie]()
    
    var offset = 1
    var limit = 20
    
    // MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSearchController()
    }
    
    // MARK:- Helper Methods
    private func configureUI() {
        view.backgroundColor = .white
        
        tableView.tableFooterView = UIView()
    }
    
    private func configureSearchController() {
        searchController = UISearchController(searchResultsController: searchResultsUpdater)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.searchController = searchController
    }
    
    func fetchData(withText searchText: String?) {
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] (_) in
            
            guard let self = self else {return}
            APIService.shared.fetchMovies(withSearchText: searchText ?? "", offset: self.offset, limit: self.limit) { (searchresults, err) in
                if let error = err {
                    // TODO:- Show Alert
                    print(error.localizedDescription)
                    return
                }
                
                self.searchResultsUpdater.searchViewController = self
                
                self.movies += searchresults?.results ?? []
                
                if let searchResults = searchresults?.resultCount {
                    self.isPaginating = searchResults < 20 ? true : false
                    self.offset = self.movies.count
                    self.searchResultsUpdater.isPaginating = self.isPaginating
                    
                    self.searchResultsUpdater.movies = self.movies
                    
                    DispatchQueue.main.async {
                        self.searchResultsUpdater.collectionView.reloadData()
                    }
                }
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- Table View Delegate and Datasource
extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emptyArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Your previous search will display here"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return emptyArray.count > 0 ? 0 : tableHeaderHeight
    }
}

// MARK:- Search Results Updater Delegate
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        self.searchText = searchText ?? ""
        
        if searchText!.isEmpty || searchText == "" {
            self.searchText = ""
            self.movies = []
            return
        }
        
        self.fetchData(withText: searchText)
    }
}

// MARK:- Search Controller Delegate
extension SearchViewController: SearchResultsUpdaterDelegate {
    func fetchMoreMovies() {
        
        self.fetchData(withText: self.searchText)
        
//        APIService.shared.fetchMovies(withSearchText: self.searchText!, offset: self.offset, limit: self.limit) { [weak self] (results, err) in
//            guard let self = self else {return}
//            if let error = err {
//                // TODO:- Show Alert
//                print(error.localizedDescription)
//                return
//            }
//
//            if let searchResults = results?.resultCount {
//                self.isPaginating = searchResults < 20 ? true : false
//                self.searchResultsUpdater.isPaginating = self.isPaginating
//
////            self.searchResultsUpdater.movies += results?.results ?? []
//                DispatchQueue.main.async {
//                    self.searchResultsUpdater.collectionView.reloadData()
//                }
//            }
//
//        }
    }
}

// MARK:- Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.offset = 1
        self.movies.removeAll()
    }
}
