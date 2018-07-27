//
//  ComicsService.swift
//  MarvelCharacters
//
//  Created by Cicero on 26/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

class ComicsService: ServiceBase {
    
    func fetch (withURL url: URL, completionHandler: @escaping (Result<[Comic], FetchError>) -> Void) {
        
        fetch(listOf: Comic.self, withURL: URL(string: url.absoluteString + getParameters())) { (result) in
            switch result {
            case .success(let comics):
                completionHandler(Result.success(comics))
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
}
