//
//  MainViewCellTests.swift
//  iTunes Movies TestTests
//
//  Created by Viswa Kodela on 7/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import XCTest
@testable import iTunes_Movies_Test

class MainViewCellTests: XCTestCase {
    
    /** Test to check title lable is not nil
     */
    func testChecktitleLabelNotEmpty() {
        let sut = MainViewCell()
        sut.configureLayout()
        XCTAssertNotNil(sut.titleLabel)
    }
    
    /** Test to checj the title lable's text is not nil
     */
    func testLabelTextNotNil() {
        let sut = MainViewCell()
        sut.configureLayout()
        
        let mainVC = MainController()
        mainVC.loadViewIfNeeded()
        mainVC.fetchGroupedMovies()
        
        for (index, group) in mainVC.groups.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = mainVC.tableView.cellForRow(at: indexPath) as? MainViewCell
            XCTAssertEqual(cell?.titleLabel.text, group.feed.results.first?.genres.first?.name)
        }
    }
}
