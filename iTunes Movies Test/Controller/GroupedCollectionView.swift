//
//  GroupedCollectionView.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit


class GroupedCollectionView: UICollectionViewController {
    
    // MARK:- Init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    // MARK:- Properties
    var movieGroup: MovieGroup?
    let groupedCollectionCellID = "groupedCollectionCellID"
    
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK:- Helper Methods
    func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(GroupedCollectionViewCell.self, forCellWithReuseIdentifier: groupedCollectionCellID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- CollectionView Delegate and dataSource
extension GroupedCollectionView: UICollectionViewDelegateFlowLayout {
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GroupedCollectionViewCell {
            cell.feedResult = self.movieGroup?.feed.results[indexPath.item]
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: groupedCollectionCellID, for: indexPath) as! GroupedCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 250
        let width = (view.frame.width - 20) / 2
        return CGSize(width: width, height: height)
    }
    
    
    
}
