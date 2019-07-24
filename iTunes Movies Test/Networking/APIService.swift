//
//  APIService.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/24/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import Foundation

class APIService: NSObject {
    
    enum NetworkURLs: String {
        case searchPageURL = "https://itunes.apple.com/search?term=spiderman&media=movie"
    }
    
    static let shared = APIService()
    
    func fetchMovies(with searchText: String, completiopn: (Result<[Movie], Error>) -> Void) {
        
    }
    
}
