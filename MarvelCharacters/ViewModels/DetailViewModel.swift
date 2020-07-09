//
//  DetailViewModel.swift
//  POCView
//
//  Created by Cicero on 02/11/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import Foundation

protocol DetailViewModelDelegate: class {
    func comicsDidChange()
    func seriesDidChange()
    func seriesFetchDidFailed()
    func comicsFetchDidFailed()
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
        guard character.comics.isEmpty else {
            viewDelegate?.comicsDidChange()
            return
        }

        comicsService.fetch(withURL: character.comicsCollectionUrl) { [weak self] result in
            switch result {
            case .success(let comics):
                self?.character.comics = comics
                self?.viewDelegate?.comicsDidChange()

            case .failure:
                self?.viewDelegate?.comicsFetchDidFailed()
            }
        }
    }
    
    func fetchSeries() {
        guard character.series.isEmpty else {
            viewDelegate?.seriesDidChange()
            return
        }

        seriesService.fetch(withURL: character.seriesCollectionUrl, completionHandler: { [weak self] result in
            switch result {
            case .success(let series):
                self?.character.series = series
                self?.viewDelegate?.seriesDidChange()

            case .failure:
                self?.viewDelegate?.seriesFetchDidFailed()
            }
        })
    }
    
    func cancelServices() {
        comicsService.cancel()
        seriesService.cancel()
    }
    
    func numberOfComics() -> Int {
        return character.comics.count
    }
    
    func numberOfSeries() -> Int {
        return character.series.count
    }

    func comicImageUrl(withIndex index: IndexPath) -> URL? {
        return character.comics[index.row].thumbnail.portraitUrl
    }
    
    func comicTitle(withIndex index: IndexPath) -> String {
        return character.comics[index.row].title
    }
    
    func serieImageUrl(withIndex index: IndexPath) -> URL? {
        return character.series[index.row].thumbnail.portraitUrl
    }
    
    func serieTitle(withIndex index: IndexPath) -> String {
        return character.series[index.row].title
    }
}
