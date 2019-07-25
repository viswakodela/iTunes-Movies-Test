//
//  GroupedCollectionViewTests.swift
//  iTunes Movies TestTests
//
//  Created by Viswa Kodela on 7/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import XCTest
@testable import iTunes_Movies_Test

class GroupedCollectionViewTests: XCTestCase {
    
    var viewController: GroupedCollectionView!
    var mainVC: MainController!
    
    override func setUp() {
        super.setUp()
        self.viewController = GroupedCollectionView()
        self.mainVC = MainController()
    }
    
    func testGroupCVCellID() {
        let sut = GroupedCollectionView()
        sut.loadViewIfNeeded()
        XCTAssertEqual("groupedCollectionCellID", sut.groupedCollectionCellID)
    }
    
    /** Test to check the movieGroup varialble is initialized
     */
    func testMovieGroupVariableEqualsIndexOfMainVC() {
        let mainVC = MainController()
        let sut = GroupedCollectionView()
        
        mainVC.loadViewIfNeeded()
        
        for (index, _) in mainVC.groups.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            XCTAssertEqual(mainVC.groups[indexPath.row], sut.movieGroup)
        }
    }
    
//    func testCellSize() {
//        let mainVC = MainController()
//        let sut = GroupedCollectionView()
//        
//        mainVC.fetchGroupedMovies()
//        mainVC.loadViewIfNeeded()
//
//        sut.loadViewIfNeeded()
//        for (index, _) in sut.movieGroup.feed.results.enumerated() {
//            let indexPath = IndexPath(item: index, section: 0)
//            let cellSize = sut.collectionView(sut.collectionView, layout: UICollectionViewFlowLayout(), sizeForItemAt: indexPath)
//            XCTAssertEqual(cellSize, CGSize(width: (sut.view.frame.width-20)/2, height: 250))
//        }
//    }
    
    func testCellsIsDisplayingWithMatchingImages() {
        
        let imageURL = viewController.movieGroup?.feed.results.first?.artworkUrl100 ?? ""
        let indePath = IndexPath(item: 0, section: 0)
        viewController.loadViewIfNeeded()
        let cell = viewController.collectionView.cellForItem(at: indePath) as? GroupedCollectionViewCell
        XCTAssertEqual(cell?.movieImageView.image, UIImage(named: imageURL))
        
        
    }
}
