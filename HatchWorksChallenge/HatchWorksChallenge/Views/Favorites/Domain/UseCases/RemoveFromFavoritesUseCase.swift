//
//  RemoveFromFavoritesUseCase.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

struct RemoveFromFavoritesUseCase {
    private let repository: FavoritesRepository

    init(
        repository: FavoritesRepository = FavoritesRepositoryImpl()
    ) {
        self.repository = repository
    }

    func execute(country: Country) {
        repository.removeFromFavorites(country: country)
    }
}
