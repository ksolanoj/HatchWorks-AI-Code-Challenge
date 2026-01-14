//
//  FavoritesRepository.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

protocol FavoritesRepository {
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
