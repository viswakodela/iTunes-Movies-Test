//
//  MainController.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/24/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class MainController: UITableViewController {
    
    // MARK:- Init
    
    
    
    // MARK: - Properties
    var movies = [Movie]()
    
    
    // MARK:-  View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    
    // MARK:- Helper Methods
    func configureLayout() {
        
        view.backgroundColor = .white
        tableView.backgroundColor = .white
    }
    
    func fetchMovies(withUrl urlString: String) {
        
    }
}


// MARK:- TableView Delegate and DataSource Methods
extension MainController {
    
    
}

