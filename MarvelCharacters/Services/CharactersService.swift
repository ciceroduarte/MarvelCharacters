//
//  CharactersService.swift
//  MarvelCharacters
//
//  Created by Cicero on 22/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

class CharactersService: ServiceBase {
    
    func fetch (completionHandler: @escaping (Result<[Character], FetchError>) -> Void) {
        
        fetch(listOf: Character.self, withURL: url(withPath: "characters")) { (result) in
            switch result {
            case .success(let characters):
                completionHandler(Result.success(characters))
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
}
