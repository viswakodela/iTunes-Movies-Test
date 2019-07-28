//
//  GroupedMovies.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import Foundation

struct MovieGroup: Decodable, Equatable {
    static func == (lhs: MovieGroup, rhs: MovieGroup) -> Bool {
        return lhs.feed.results.count == rhs.feed.results.count
    }
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let id: String
    let name: String
    let artistName: String
    var artworkUrl100: String?
    let genres: [Genre]
}

struct Genre: Decodable {
    let name: String
}
