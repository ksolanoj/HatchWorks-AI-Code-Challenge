//
//  FavoritesRepositoryImpl.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

struct FavoritesRepositoryImpl: FavoritesRepository {

    // Data Sources
    private let favoritesDataSource: FavoritesDataSource

    init(
        favoritesDataSource: FavoritesDataSource = FavoritesDataSourceImpl()
    ) {
        self.favoritesDataSource = favoritesDataSource
    }

    func getFavorites() -> [Country] {
        return favoritesDataSource.getFavorites()
    }
    
    func addToFavorites(country: Country) {
        favoritesDataSource.addToFavorites(country: country)
    }
    
    func removeFromFavorites(country: Country) {
        favoritesDataSource.removeFromFavorites(country: country)
    }

    func isFavorite(country: Country) -> Bool {
        return favoritesDataSource.isFavorite(country: country)
    }
}
