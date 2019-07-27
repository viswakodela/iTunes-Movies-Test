//
//  SearchResultsUpdater.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/26/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

protocol SearchResultsUpdaterDelegate: class {
    func fetchMoreMovies()
}

class SearchResultsUpdater: UICollectionViewController {
    
    // MARK:- Init
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    // MARK:- Properties
    weak var searchViewController: SearchViewController?
    var isPaginating = false
    var movies = [Movie]()
    let moviesCellID = "moviesCellID"
    weak var delegate: SearchResultsUpdaterDelegate?
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK:- Helper Methds
    func configureUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
//        collectionView.prefetchDataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(SearchResultsUpdaterCell.self, forCellWithReuseIdentifier: moviesCellID)
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? SearchResultsUpdaterCell {
            cell.movie = self.movies[indexPath.item]
            
            if indexPath.item == self.movies.count - 1 && !isPaginating {
                self.isPaginating = true
                delegate?.fetchMoreMovies()
                self.isPaginating = false
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moviesCellID, for: indexPath) as! SearchResultsUpdaterCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 250
        let width: CGFloat = (view.frame.width - 30) / 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK:- Prefetch the movies when there is only 4 cells left to display
//extension SearchResultsUpdater: UICollectionViewDataSourcePrefetching {
//
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        indexPaths.forEach { (indexpath) in
//            if indexpath.item == self.movies.count - 1 && !self.searchViewController!.isPaginating {
//                self.searchViewController!.isPaginating = true
//                self.delegate?.fetchMoreMovies()
//                self.searchViewController!.isPaginating = false
//                self.searchViewController?.offset = movies.count
//            }
//        }
//    }
//}
