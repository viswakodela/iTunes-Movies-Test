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
        
        let expectation = XCTestExpectation(description: "Search Controller not tnil")
        
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
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
    
    
    
    

}
