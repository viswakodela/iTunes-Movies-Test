//
//  SearchControllerTests.swift
//  iTunes Movies TestTests
//
//  Created by Viswa Kodela on 7/26/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import XCTest
@testable import iTunes_Movies_Test

class SearchControllerTests: XCTestCase {
    
    func testNavControllerTitle() {
        let tabBar = TabBarController()
        
        if tabBar.selectedIndex == 1 {
            let sut = SearchViewController(searchResultsUpdater: SearchResultsUpdater())
            let navSearchVC = UINavigationController(rootViewController: sut)
            navSearchVC.navigationItem.title = "Search"
            sut.loadViewIfNeeded()
            XCTAssertEqual(sut.navigationItem.title, "Search")
        }
    }
    
    func testSearchBarIsTableViewController() {
        let sut = SearchViewController(searchResultsUpdater: SearchResultsUpdater())
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView)
    }
    
    func testSearchBarSearchControllerNotNil() {
        let sut = SearchViewController(searchResultsUpdater: SearchResultsUpdater())
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.searchController)
    }
    
    func testIfArrayIsEmptyDisplayText() {
        
        let sut = SearchViewController(searchResultsUpdater: SearchResultsUpdater())
        sut.loadViewIfNeeded()
        
        if sut.emptyArray.count > 0 {
            XCTAssertEqual(sut.tableView.rectForHeader(inSection: 0).height, 0)
        } else if sut.emptyArray.isEmpty {
            XCTAssertEqual(sut.tableView.rectForHeader(inSection: 0).height, sut.tableHeaderHeight)
        }
    }
    
    func testSearchResultsUpdaterArrayToEmpty() {
        let sut = SearchViewController(searchResultsUpdater: SearchResultsUpdater())
        sut.loadViewIfNeeded()
        
        let expectation = XCTestExpectation(description: "Search Results Controller array Empty")
        
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        if sut.searchController.searchBar.text?.count == 0 {
            XCTAssertEqual(sut.searchResultsUpdater.movies.count, 0)
        }
    }
    
    func testArrayCountEqualToCellsCount() {
        let sut = SearchViewController(searchResultsUpdater: SearchResultsUpdater())
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.emptyArray.count, sut.tableView.numberOfRows(inSection: 0))
    }
    
    func testSearResultsUpdaterIsNeverNil() {
        let sut = SearchViewController(searchResultsUpdater: SearchResultsUpdater())
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.searchResultsUpdater)
    }
    
    func testSearchText() {
        let sut = SearchViewController(searchResultsUpdater: SearchResultsUpdater())
        sut.loadViewIfNeeded()
        let searchText = sut.searchController.searchBar.text
        XCTAssertEqual(searchText, sut.searchText)
    }
    

    
    
//    func testMovieNameWithCellsTitleName() {
//        let sut = SearchViewController(searchResultsUpdater: SearchResultsUpdater())
//        sut.loadViewIfNeeded()
//        
//        let searUpdater = SearchResultsUpdater()
//        
//        sut.fetchData(withText: "Spider")
//        
//        let movies = searUpdater.movies
//        
//        let cell = searUpdater.collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! SearchResultsUpdaterCell
//        
//        XCTAssertEqual(cell.moviewName.text, movies[0].trackName)
//        
//        
//    }

}
