//
//  FavoritesViewModel.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

@Observable
@MainActor
final class FavoritesViewModel {
    
    // Published Properties
    private(set) var screenState: ScreenState
    private(set) var countries: [Country]

    // Use Cases
    @ObservationIgnored
    private let getFavorites: GetFavoritesUseCase

    init(
        getFavorites: GetFavoritesUseCase
    ) {
        self.screenState = .loading
        self.countries = []
        self.getFavorites = getFavorites
    }

    func getFavoriteCountries() {
        countries = getFavorites.execute()
        screenState = countries.isEmpty ? .noFavorites : .loaded
    }
}

extension FavoritesViewModel {
    enum ScreenState {
        case loading
        case loaded
        case noFavorites
    }
}
