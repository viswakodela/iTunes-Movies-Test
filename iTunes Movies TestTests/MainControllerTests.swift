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
    
    func testNumberOfCellsEqualToNumberOfMovies() {
        let sut = MainController()
        
        let movies = sut.movies
        
        let totalRows = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(movies.count, totalRows)
    }
    
    func testFetchMovies() {
        let sut = MainController()
        
        
        
    }
    
    

}
