//
//  SeriesService.swift
//  MarvelCharacters
//
//  Created by Cicero on 26/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

class SeriesService: ServiceBase {
    
    func fetch (withURL url: URL, completionHandler: @escaping (Result<[Serie], FetchError>) -> Void) {
        
        fetch(listOf: Serie.self, withURL: URL(string: url.absoluteString + getParameters())) { (result) in
            switch result {
            case .success(let series):
                completionHandler(Result.success(series))
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
}
