//
//  MainControllerTests.swift
//  iTunes Movies TestTests
//
//  Created by Viswa Kodela on 7/24/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import XCTest
@testable import iTunes_Movies_Test

class MainControllerTests: XCTestCase {
    
    
    /**Tests whether the tableView exist or not
     */
    func testTableViewExist() {
        // given
        let sut = MainController()
        
        // when
        sut.loadViewIfNeeded()
        
        // then
        XCTAssertNotNil(sut.collectionView)
    }
    
    /** Test to check whether the cells of the TableView are equal to the movies array
     */
    func testNumberOfCellsEqualToNumberOfMovies() {
        let sut = MainController()
        let groups = sut.groups
        
        // when
        sut.loadViewIfNeeded()
        
        let totalRows = sut.collectionView.numberOfItems(inSection: 0)
        
        XCTAssertEqual(groups.count, totalRows)
    }
    
    func testtableViewCellID() {
        let sut = MainController()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.mainCellID, "mainCellID")
    }
    
    func testNavControllerPresent() {
        let sut = MainController()
        _ = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.navigationController)
    }
    
    /**Test whether the cell's textLabel is equal to the same as the one in the index of the element in Movies Array.
     */
    func testTableViewTextInsideThetextLabel() {
        // given
        let sut = MainController()
        
        // when
        sut.loadViewIfNeeded()
        
        // then
        for (index, movie) in sut.groups.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = sut.collectionView.cellForItem(at: indexPath) as? MainViewCell
            XCTAssertEqual(cell?.titleLabel.text, movie.feed.title)
        }
    }
    
    func testNavBArLargeTitles() {
        let sut = MainController()
        _ = UINavigationController(rootViewController: sut)
        
        sut.loadViewIfNeeded()
        
        XCTAssertTrue(sut.navigationController!.navigationBar.prefersLargeTitles)
    }
    
    func testTestCellisMainViewCell() {
        let sut = MainController()
        
        sut.loadViewIfNeeded()
        
        for (index, _) in sut.groups.enumerated() {
            
            let indexPath = IndexPath(row: index, section: 0)
            let cell = sut.collectionView.cellForItem(at: indexPath) as? MainViewCell
            XCTAssertNotNil(cell)
        }
    }
    
    func testNavBarTitle() {
        let tabBar = TabBarController()
        
        if tabBar.selectedIndex == 0 {
            let navMainVC = UINavigationController(rootViewController: MainController())
            navMainVC.navigationItem.title = "Hello"
            
            XCTAssertEqual(navMainVC.navigationItem.title, "Hello")
        }
    }
    

        
//    /** Test to check whether we fetch movies form the API
//     */
//    func testFetchMovies() {
//        let sut = MainController()
//
//        let movies = sut.fetchMovies(withUrl: NetworkURLs.searchPageURL.rawValue)
//
//        if movies.count > 0 {
//            XCTAssertNotNil(movies)
//        }
//    }
//
//    func testCheckRegisteredCellID() {
//        let sut = MainController()
//
//
//    }
}
