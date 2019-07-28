//
//  DetailsViewController.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/27/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class MovieDetailsController: UICollectionViewController {
    
    // MARK:- Init
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    // MARK:- Properties
    var selectedMovie: Movie?
    let regularCell = "regularCell"
    let movieStoryLineCell = "movieStoryLineCell"
    let movieDetailsHeader = "movieDetailsHeader"
    
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK:- Helper Methods
    fileprivate func configureUI() {
        view.backgroundColor = .white
        
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: regularCell)
        collectionView.register(MovieStoryLineCell.self, forCellWithReuseIdentifier: movieStoryLineCell)
        collectionView.register(MovieDetailsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: movieDetailsHeader)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- Collection View Delagete and DataSource Methods
extension MovieDetailsController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieStoryLineCell, for: indexPath) as! MovieStoryLineCell
            cell.movie = self.selectedMovie
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: regularCell, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = MovieStoryLineCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: .greatestFiniteMagnitude))
        cell.movie = self.selectedMovie
        cell.layoutIfNeeded()

        let estimatedsize = cell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: .greatestFiniteMagnitude))
        return CGSize(width: view.frame.width, height: estimatedsize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height: CGFloat = 200
        let width = view.frame.width - 20
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: movieDetailsHeader, for: indexPath) as! MovieDetailsHeaderView
        header.movie = self.selectedMovie
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}
