//
//  FavoritesDataSource.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

protocol FavoritesDataSource {
    /// Function used to fetch favorite's countries
    /// - Returns: List of Countries
    func getFavorites() -> [Country]
    
    /// Function used to add a country to favorites
    /// - Parameter country: Country object
    func addToFavorites(country: Country)
    
    /// Function to remove a country from favorites
    /// - Parameter country: Country Object
    func removeFromFavorites(country: Country)

    /// Function used to check if a country is added to Favorites
    /// - Parameter country: Country Object
    /// - Returns: Boolean indicating if the country is added to favorites or not
    func isFavorite(country: Country) -> Bool
}

struct FavoritesDataSourceImpl: FavoritesDataSource {

    private let userDefaultsKey = "favorites.countries"

    func getFavorites() -> [Country] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let favorites = try? JSONDecoder().decode([Country].self, from: data)
        else { return [] }
        return favorites
    }

    func addToFavorites(country: Country) {
        var favorites = getFavorites()
        guard favorites.contains(where: { $0.id == country.id }) == false else { return }
        favorites.append(country)
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }

    func removeFromFavorites(country: Country) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == country.id }
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }

    func isFavorite(country: Country) -> Bool {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let favorites = try? JSONDecoder().decode([Country].self, from: data)
        else { return false }

        return favorites.contains { $0.id == country.id }
    }
}
