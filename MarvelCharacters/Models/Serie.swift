//
//  Serie.swift
//  MarvelCharacters
//
//  Created by Cicero on 27/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

struct Serie: Representable {
    
    var title: String
    var image: Image
    
    init? (withRepresentation representation: [String: Any]?) {
        
        guard let title = representation?["title"] as? String,
            let imageRepresentation = representation?["thumbnail"] as? [String: Any],
            let image = Image(withRepresentation: imageRepresentation) else {
                return nil
        }
        self.title = title
        self.image = image
    }
}
