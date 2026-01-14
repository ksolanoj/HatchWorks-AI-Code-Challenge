//
//  FavoritesRepositoryMock.swift
//  HatchWorksChallengeTests
//
//  Created by Kevin Solano Jiménez on 14/1/26.
//

@testable import HatchWorksChallenge
import Foundation

final class FavoritesRepositoryMock: FavoritesRepository {
    var getFavoritesResult: [Country]
    var isFavoriteResult: Result<Bool, Error>

    // Call tracking
    private(set) var addToFavoritesCalled: Bool = false
    private(set) var removeFromFavoritesCalled: Bool = false

    static let successResponse: [Country] = [
        Country(name: "Costa Rica", flagURL: URL(string: "https://example.com/cr.png"), population: 5_200_000),
        Country(name: "Japan", flagURL: URL(string: "https://example.com/jp.png"), population: 125_000_000)
    ]

    init(
        getFavoritesResult: [Country] = FavoritesRepositoryMock.successResponse,
        isFavoriteResult: Result<Bool, Error> = .success(false)
    ) {
        self.getFavoritesResult = getFavoritesResult
        self.isFavoriteResult = isFavoriteResult
    }

    func getFavorites() -> [Country] {
        getFavoritesResult
    }

    func addToFavorites(country: Country) {
        addToFavoritesCalled.toggle()
    }

    func removeFromFavorites(country: Country) {
        removeFromFavoritesCalled.toggle()
    }

    func isFavorite(country: Country) -> Bool {
        switch isFavoriteResult {
        case .success(let value):
            return value
        case .failure:
            return false
        }
    }
}
