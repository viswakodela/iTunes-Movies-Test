//
//  SearchResultsUpdaterTests.swift
//  iTunes Movies TestTests
//
//  Created by Viswa Kodela on 7/26/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import XCTest
@testable import iTunes_Movies_Test

class SearchResultsUpdaterTests: XCTestCase {
    
    func testArrayCountEqualsCellsCount() {
        let sut = SearchResultsUpdater()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.movies.count, sut.collectionView.numberOfItems(inSection: 0))
    }
    
    func testRegistedCellName() {
        let sut = SearchResultsUpdater()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.moviesCellID, "moviesCellID")
    }
    
    func testMoviesCountequalsCellCount() {
        let sut = SearchResultsUpdater()
        sut.loadViewIfNeeded()
        let totalItems = sut.collectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(sut.movies.count, totalItems)
    }
}
