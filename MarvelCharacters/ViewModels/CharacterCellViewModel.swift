//
//  CharacterCellViewModel.swift
//  POCView
//
//  Created by Cicero on 22/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import Foundation

class CharacterCellViewModel: CharacterHandler {
    
    var character: Character
    
    init(withCharacter character: Character) {
        self.character = character
    }
}
