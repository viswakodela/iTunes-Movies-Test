//
//  APIServiceTests.swift
//  iTunes Movies TestTests
//
//  Created by Viswa Kodela on 7/24/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import XCTest
@testable import iTunes_Movies_Test

class APIServiceTests: XCTestCase {
    
    
    func testGetMoviesWithExpectedURLHostAndPath() {
        // given
        let service = APIService.shared
        let moviesURL = APIService.NetworkURLs.searchPageURL.rawValue
        // when
        
        
        // then
        service.fetchMovies(with: "") { (res) in }
        
        XCTAssertEqual(moviesURL, "https://itunes.apple.com/search?term=spiderman&media=movie")
    }

}
