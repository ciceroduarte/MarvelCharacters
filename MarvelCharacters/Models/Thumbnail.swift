//
//  Thumbnail.swift
//  MarvelCharacters
//
//  Created by Cicero on 16/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

struct Thumbnail: Decodable {
    
    let path: String
    let imageExtension: String

    private enum CodingKeys: String, CodingKey {
        case path,
        imageExtension = "extension"
    }

    var url: URL? {
        return URL(string: path + "/standard_amazing." + imageExtension)
    }
    
    var portraitUrl: URL? {
        return URL(string: path + "/portrait_fantastic." + imageExtension)
    }
}
