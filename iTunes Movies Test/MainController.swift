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
}

class MainController: UITableViewController {
    
    // MARK:- Init
    
    
    
    // MARK: - Properties
    let mainCellID = "mainCellID"
    var movies = [Movie]()
    
    
    // MARK:-  View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        fetchMovies(withUrl: NetworkURLs.searchPageURL.rawValue)
    }
    
    
    // MARK:- Helper Methods
    func configureLayout() {
        
        view.backgroundColor = .white
        
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: mainCellID)
    }
    
    
    /**
     Call this method to fetch the movies based on the users search entry
     */
    func fetchMovies(withUrl urlString: String) {

        APIService.shared.fetchMovies(withSearchText: "spider man") { [weak self] (searchResults, err) in
            guard let self = self else {return}
            if let error = err {
                // TODO:- Show Alert
                print(error.localizedDescription)
                return
            }
            
            self.movies += searchResults?.results ?? []
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


// MARK:- TableView Delegate and DataSource Methods
extension MainController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: mainCellID)
        cell.textLabel?.text = self.movies[indexPath.row].trackName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

