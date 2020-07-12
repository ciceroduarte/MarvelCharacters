//
//  CharacterMock.swift
//  MarvelCharactersTests
//
//  Created by Cícero Duarte da Silva on 11/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import Foundation
@testable import MarvelCharacters

struct CharacterMock {
    static var instance: Character {
        return Character(name: "cicero",
                         characterDescription: "",
                         thumbnail: Thumbnail(path: "abc", imageExtension: "png"),
                         comicsInfo: Comics(available: 1, collectionURI: URL(string: "http://abc.com")!),
                         seriesInfo: Series(available: 1, collectionURI: URL(string: "http://abc.com")!))
    }
}
