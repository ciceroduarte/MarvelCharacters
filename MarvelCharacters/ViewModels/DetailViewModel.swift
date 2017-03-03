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
    func seriesDidChange() -> Void
    func seriesFetchDidFailed() -> Void
    func comicsFetchDidFailed() -> Void
}

class DetailViewModel: CharacterHandler {
    
    // MARK: Properties
    let comicsService = ComicsService()
    let seriesService = SeriesService()
    var character: Character
    weak var viewDelegate: DetailViewModelDelegate?
    
    init(withCharacter character: Character) {
        self.character = character
    }
    
    func fetchComics() {
        
        if character.comics != nil {
            viewDelegate?.comicsDidChange()
            return
        }
        
        comicsService.fetch(withURL: character.comicsCollectionURI) { [weak self] result in
            switch result {
            case .success(let comics):
                self?.character.comics = comics
                self?.viewDelegate?.comicsDidChange()            

            case .failure( _):
                self?.viewDelegate?.comicsFetchDidFailed()
            }
        }
    }
    
    func fetchSeries() {

        if character.series != nil {
            viewDelegate?.seriesDidChange()
            return
        }
        
        seriesService.fetch(withURL: character.seriesCollectionURL, completionHandler: { [weak self] result in
            switch result {
            case .success(let series):
                self?.character.series = series
                self?.viewDelegate?.seriesDidChange()
                
            case .failure( _):
                self?.viewDelegate?.seriesFetchDidFailed()
            }
        })
    }
    
    func cancelServices() {
        comicsService.cancel()
        seriesService.cancel()
    }
    
    func numberOfComics () -> Int {
        return character.comics?.count ?? 0
    }
    
    func numberOfSeries () -> Int {
        return character.series?.count ?? 0
    }

    func comicImageUrl(withIndex index: IndexPath) -> URL? {
        return character.comics?[index.row].image.portraitUrl
    }
    
    func comicTitle(withIndex index: IndexPath) -> String {
        return character.comics?[index.row].title ?? ""
    }
    
    func serieImageUrl(withIndex index: IndexPath) -> URL? {
        return character.series?[index.row].image.portraitUrl
    }
    
    func serieTitle(withIndex index: IndexPath) -> String {
        return character.series?[index.row].title ?? ""
    }
}
