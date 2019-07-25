//
//  MainController.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/24/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit


enum NetworkURLs: String {
    case searchPageURL = "https://itunes.apple.com/search"
    case groupedDocumentaryURL = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/documentary/25/explicit.json"
    case groupedActionandAdventureMovieURL = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/action-and-adventure/25/explicit.json"
}

class MainController: UITableViewController {
    
    // MARK:- Init
    
    
    
    // MARK: - Properties
    let mainCellID = "mainCellID"
    let tableViewRowheight: CGFloat = 300
    var groups = [MovieGroup]()
    
    private var dispatchGroup: DispatchGroup!
    
    private var offset = 0
    private var limit = 20
    
    
    // MARK:-  View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureNavigationBar()
        fetchGroupedMovies()
//        fetchMovies(withUrl: NetworkURLs.searchPageURL.rawValue)
    }
    
    
    // MARK:- Helper Methods
    func configureLayout() {
        
        view.backgroundColor = .white
        
        tableView.backgroundColor = .white
        tableView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        tableView.allowsSelection = false
        tableView.rowHeight = self.tableViewRowheight
        tableView.isScrollEnabled = false
        tableView.register(MainViewCell.self, forCellReuseIdentifier: mainCellID)
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /** Call this method to fetch the different groups of Movies eg: Documentary, Action..
     */
    func fetchGroupedMovies() {
        
        self.dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIService.shared.fetchGroupedMovies(withUrl: NetworkURLs.groupedDocumentaryURL.rawValue) { [weak self] (movieGroups, err) in
            guard let self = self else {return}
            self.dispatchGroup.leave()
            if let error = err {
                // TODO:- Show Error
                print(error.localizedDescription)
                return
            }
            guard let documentryGroup = movieGroups else {return}
            self.groups.append(documentryGroup)
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchGroupedMovies(withUrl: NetworkURLs.groupedActionandAdventureMovieURL.rawValue) { [weak self] (actionGroup, err) in
            guard let self = self else {return}
            self.dispatchGroup.leave()
            if let error = err {
                // TODO:- Show Alert
                print(error.localizedDescription)
                return
            }
            guard let actionGroup = actionGroup else {return}
            self.groups.append(actionGroup)
        }
        
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    /**
     Call this method to fetch the movies based on the users search entry
     */
//    func fetchMovies(withUrl urlString: String) {
//
//        APIService.shared.fetchMovies(withSearchText: "Marvel", offset: offset, limit: limit) { [weak self] (searchResults, err) in
//
//            guard let self = self else {return}
//            if let error = err {
//                // TODO:- Show Alert
//                print(error.localizedDescription)
//                return
//            }
//
//            self.movies += searchResults?.results ?? []
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
}


// MARK:- TableView Delegate and DataSource Methods
extension MainController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mainCellID, for: indexPath) as! MainViewCell
        let genre = self.groups[indexPath.row].feed.results.first?.genres.first?.name
        cell.titleLabel.text = genre
        cell.groupedCollectionView.movieGroup = self.groups[indexPath.row]
        cell.groupedCollectionView.collectionView.reloadData()
        return cell
    }
    
}

