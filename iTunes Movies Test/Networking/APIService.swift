//
//  APIService.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/24/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkURLs: String {
    case searchPageURL = "https://itunes.apple.com/search"
    case groupedDocumentaryURL = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/documentary/50/explicit.json"
    case groupedActionandAdventureMovieURL = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/action-and-adventure/50/explicit.json"
    case groupedTVShowsURL = "https://rss.itunes.apple.com/api/v1/ca/tv-shows/top-tv-episodes/all/50/explicit.json"
}

class APIService: NSObject {
    
    static let shared = APIService()
    
    /**Call this method to fetch the SearchResults fomr the iTUnes Search URL based on the User's Search Text
     */
    func fetchMovies(withSearchText searchText: String, offset: Int, limit: Int, completion: @escaping (SearchResults?, Error?) -> Void) {
        guard let url = URL(string: NetworkURLs.searchPageURL.rawValue) else {return}
        let params: Parameters = ["term": searchText, "media": "movie", "offset": offset, "limit": limit]
        Alamofire.request(url,
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding.default,
                          headers: nil).responseData { (respData) in
                            guard let data = respData.data else {return}
                            
                            do {
                                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                                completion(searchResult, nil)
                            } catch let error {
                                completion(nil, error)
                            }
        }
    }
    
    /**Call this method to get the Grouped Movies eg: Top Moves, Recent Movies
     */
    func fetchGroupedMovies(withUrl urlSrting: String, completion: @escaping (MovieGroup?, Error?) -> Void) {
        guard let url = URL(string: urlSrting) else {return}
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { (dataResp) in
            guard let data = dataResp.data else {return}
            
            do {
                let group = try JSONDecoder().decode(MovieGroup.self, from: data)
                completion(group, nil)
            } catch let error {
                completion(nil, error)
            }
        }
    }
}


