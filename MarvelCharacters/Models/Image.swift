//
//  Image.swift
//  MarvelCharacters
//
//  Created by Cicero on 16/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

struct Image {
    
    private let path: String
    private let imageExtension: String
    
    init?(withRepresentation representation: [String: Any]?) {
        
        guard let path = representation?["path"] as? String,
            let imageExtension = representation?["extension"] as? String else {
                return nil
        }
        
        self.path = path
        self.imageExtension = imageExtension
    }
    
    var url: URL? {
        return URL(string: path + "/standard_amazing." + imageExtension)
    }
}
