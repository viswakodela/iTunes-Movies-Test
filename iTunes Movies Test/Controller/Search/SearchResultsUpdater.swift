//
//  SearchResultsUpdater.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/26/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class SearchResultsUpdater: UICollectionViewController {
    
    // MARK:- Init
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    // MARK:- Properties
    var movies = [Movie]()
    let moviesCellID = "moviesCellID"
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK:- Helper Methds
    func configureUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: moviesCellID)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- Collection View Delegate and DataSource
extension SearchResultsUpdater: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moviesCellID, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
}
