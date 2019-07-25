//
//  SearchResults.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let resultCount: Int
    let results: [Movie]
}
