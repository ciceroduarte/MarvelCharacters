//
//  DetailViewModel.swift
//  POCView
//
//  Created by Cicero on 02/11/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import Foundation

protocol DetailViewModelDelegate : class {
    func comicsDidChange() -> Void
}

class DetailViewModel: CharacterHandler {
    
    // MARK: Properties
    var character: Character
    weak var viewDelegate: DetailViewModelDelegate?
    
    init(withCharacter character: Character) {
        self.character = character
    }
    
    func fetchComics() {
        let comicsService = ComicsService()
        
        comicsService.fetch(withURL: character.comicsCollectionURI) { [weak self] result in
            switch result {
            case .success(let comics):
                self?.character.comics = comics
                self?.viewDelegate?.comicsDidChange()                

            case .failure( _): print("Error")
            }
        }
    }
    
    func numberOfComics () -> Int {
        return character.comics?.count ?? 0
    }
    
    func comicImageUrl(withIndex index: IndexPath) -> URL? {
        return character.comics?[index.row].image?.portraitUrl
    }
    
    func comicTitle(withIndex index: IndexPath) -> String {
        return character.comics?[index.row].title ?? ""
    }
}
