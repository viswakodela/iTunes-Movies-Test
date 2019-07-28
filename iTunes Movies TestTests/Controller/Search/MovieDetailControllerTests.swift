//
//  MovieDetailControllerTests.swift
//  iTunes Movies TestTests
//
//  Created by Viswa Kodela on 7/27/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import XCTest
@testable import iTunes_Movies_Test

class MovieDetailControllerTests: XCTestCase {
    
    func testCheckCellCount() {
        let sut = MovieDetailsController()
        sut.loadViewIfNeeded()
        XCTAssertEqual(1, sut.collectionView.numberOfItems(inSection: 0))
    }
}
