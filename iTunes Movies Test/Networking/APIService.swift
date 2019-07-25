//
//  APIService.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/24/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import Foundation
import Alamofire

class APIService: NSObject {
    
    static let shared = APIService()
    
    /**Call this method to fetch the SearchResults fomr the iTUnes Search URL based on the User's Search Text
     */
    func fetchMovies(withSearchText searchText: String, offset: Int, limit: Int, completion: @escaping (SearchResults?, Error?) -> Void) {
        guard let url = URL(string: NetworkURLs.searchPageURL.rawValue) else {return}
        let params: Parameters = ["term": "Marvel", "media": "movie", "offset": offset, "limit": limit]
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
