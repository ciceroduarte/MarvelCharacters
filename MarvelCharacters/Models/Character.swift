//
//  Character.swift
//  MarvelCharacters
//
//  Created by Cicero on 16/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

struct Character: Representable {
    
    let name: String
    let characterDescription: String
    let comicsCollectionURI: URL
    let seriesCollectionURL: URL
    let image: Image
    var comics: [Comic]?
    var series: [Serie]?
    
    init? (withRepresentation representation: [String: Any]?) {
        
        guard let name = representation?["name"] as? String,
            let characterDescription = representation?["description"] as? String,
            let imageRepresentation = representation?["thumbnail"] as? [String: Any],
            let image = Image(withRepresentation: imageRepresentation),
            let comicsRepresentation = representation?["comics"] as? [String: Any],
            let comicsCollectionURIString = comicsRepresentation["collectionURI"] as? String,
            let comicsCollectionURI = URL(string: comicsCollectionURIString),
            let seriesRepresentation = representation?["series"] as? [String: Any],
            let seriesCollectionURIString = seriesRepresentation["collectionURI"] as? String,
            let seriesCollectionURI = URL(string: seriesCollectionURIString) else {
                return nil
        }
        
        self.name = name
        self.characterDescription = characterDescription
        self.comicsCollectionURI = comicsCollectionURI
        self.seriesCollectionURL = seriesCollectionURI
        self.image = image
    }
}
