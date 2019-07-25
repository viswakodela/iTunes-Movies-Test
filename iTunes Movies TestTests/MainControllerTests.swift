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
        XCTAssertNotNil(sut.tableView)
    }
    
    /** Test to check whether the cells of the TableView are equal to the movies array
     */
    func testNumberOfCellsEqualToNumberOfMovies() {
        let sut = MainController()
        let movies = sut.movies
        
        // when
        sut.loadViewIfNeeded()
        
        let totalRows = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(movies.count, totalRows)
    }
    
    /**Test whether the cell's textLabel is equal to the same as the one in the index of the element in Movies Array.
     */
    func testTableViewTextInsideThetextLabel() {
        // given
        let sut = MainController()
        
        // when
        sut.loadViewIfNeeded()
        
        // then
        for (index, movie) in sut.movies.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(cell.textLabel?.text, movie.trackName)
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
