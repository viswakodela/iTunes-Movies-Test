//
//  MainController.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/24/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class MainController: UICollectionViewController {
    
    // MARK:- Init
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    
    // MARK: - Properties
    let mainCellID = "mainCellID"
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
        
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        collectionView.allowsSelection = false
        collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: mainCellID)
    }
    
    func configureNavigationBar() {
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
        
        dispatchGroup.enter()
        APIService.shared.fetchGroupedMovies(withUrl: NetworkURLs.groupedTVShowsURL.rawValue) { [weak self] (tvShows, err) in
            guard let self = self else {return}
            self.dispatchGroup.leave()
            if let error = err {
                // TODO:- Show Alert
                print(error.localizedDescription)
                return
            }
            guard let tvShows = tvShows else {return}
            self.groups.append(tvShows)
        }
        
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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


// MARK:- CollectionView Delegate and DataSource Methods
extension MainController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainCellID, for: indexPath) as! MainViewCell
        let genre = self.groups[indexPath.row].feed.results.first?.genres.first?.name
        cell.titleLabel.text = "\(genre ?? "")"
        cell.groupedCollectionView.movieGroup = self.groups[indexPath.row]
        cell.groupedCollectionView.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 300
        let width = view.frame.width - 10
        return CGSize(width: width, height: height)
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.groups.count
//    }
//
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: mainCellID, for: indexPath) as! MainViewCell
//        let genre = self.groups[indexPath.row].feed.results.first?.genres.first?.name
//        cell.titleLabel.text = genre
//        cell.groupedCollectionView.movieGroup = self.groups[indexPath.row]
//        cell.groupedCollectionView.collectionView.reloadData()
//        return cell
//    }
    
}

