//
//  ServiceResponse.swift
//  MarvelCharacters
//
//  Created by Cicero on 22/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

struct ServiceResponse {
    
    let results: [[String : Any]]
    let offset: Int
    let count: Int
    let total: Int
    
    init?(_ data: Data?) {
        guard let theData = data,
            let json = try? JSONSerialization
                .jsonObject(with: theData, options:JSONSerialization.ReadingOptions(rawValue: 0)),
            let jsonDictionary = json as? NSDictionary,
            let data = jsonDictionary.object(forKey: "data") as? NSDictionary,
            let results = data.object(forKey: "results") as? [[String : Any]],
            let offset = data.object(forKey: "offset") as? Int,
            let count = data.object(forKey: "count") as? Int,
            let total = data.object(forKey: "total") as? Int else {
                return nil
        }
    
        self.results = results
        self.offset = offset
        self.count = count
        self.total = total
    }
}
