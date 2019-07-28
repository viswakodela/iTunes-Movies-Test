//
//  Movie.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/24/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let trackName: String
    var artworkUrl100: String?
    let artistName: String?
    let releaseDate: String?
    var trackPrice: Float?
    var primaryGenreName: String
    var shortDescription: String?
    var longDescription: String?
}
