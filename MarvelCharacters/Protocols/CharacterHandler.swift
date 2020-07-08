//
//  HeroHandler.swift
//  MarvelHeroes
//
//  Created by Cicero on 23/06/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import Foundation

protocol CharacterHandler {
    var character: Character { get }
}

extension CharacterHandler {
    
    func characterName () -> String {
        return character.name
    }
    
    func characterImage () -> URL? {
        return character.thumbnail.url
    }
}
