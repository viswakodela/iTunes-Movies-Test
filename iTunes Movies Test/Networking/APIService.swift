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
    
    func fetchMovies(withSearchText searchText: String, completion: @escaping (SearchResults?, Error?) -> Void) {
        guard let url = URL(string: NetworkURLs.searchPageURL.rawValue) else {return}
        let params: Parameters = ["term": "spider man", "media": "movie"]
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
    
}
