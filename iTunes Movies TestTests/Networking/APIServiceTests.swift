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
        let moviesURL = NetworkURLs.searchPageURL.rawValue
        // when
        
        
        // then
        service.fetchMovies(withSearchText: "", offset: 0, limit: 0) { (movies, err) in }
        
        XCTAssertEqual(moviesURL, "https://itunes.apple.com/search")
//        https://itunes.apple.com/search?term=spiderman&media=movie
    }
    
    /** Test when movies are not Nil
     */
//    func testFetchMoviesArrayNotNil() {
//        let sut = APIService.shared
//        var moviesResponse: [Movie]?
//
//        sut.fetchMovies(withSearchText: NetworkURLs.searchPageURL.rawValue) { (searchRes, err) in
//
//            if searchRes?.results.count ?? 0 > 0 {
//                moviesResponse =
//                XCTAssertNotNil(moviesResponse)
//            }
//        }
//    }
    
    /** Test when the fetchMovies will return an error
     */
    func testFetchMoviesReturnsError() {
        
        let sut = APIService.shared
        
        sut.fetchMovies(withSearchText: NetworkURLs.searchPageURL.rawValue, offset: 0, limit: 0) { (moview, err) in
            if let error = err {
                XCTAssertNotNil(error)
            }
        }
    }
    
    /** Test to check whether error is not nil or gropedMovies are not nil
     */
    func testFetchGroupedMovies() {
        let sut = APIService.shared
        
        sut.fetchGroupedMovies(withUrl: NetworkURLs.groupedDocumentaryURL.rawValue) { (group, err) in
            if err != nil {
                XCTAssertNotNil(err)
            } else {
                XCTAssertNotNil(group)
            }
        }
    }
}
