//
//  CountryDetailViewModel.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import SwiftUI

@Observable
@MainActor
final class CountryDetailViewModel {

    // Published Properties
    private(set) var screenState: ScreenState
    private(set) var addToFavoritesButtonIcon: String

    // Properties
    @ObservationIgnored
    private(set) var tappedCountry: Country
    @ObservationIgnored
    private(set) var countryDetail: CountryDetail?

    // UseCases
    @ObservationIgnored
    private let getCountryDetailUseCase: GetCountryDetailUseCase
    @ObservationIgnored
    private let addToFavoritesUseCase: AddToFavoritesUseCase
    @ObservationIgnored
    private let removeFromFavoritesUseCase: RemoveFromFavoritesUseCase
    @ObservationIgnored
    private let isFavoriteUseCase: IsFavoriteUseCase

    init(
        tappedCountry: Country,
        getCountryDetailUseCase: GetCountryDetailUseCase,
        addToFavoritesUseCase: AddToFavoritesUseCase,
        removeFromFavoritesUseCase: RemoveFromFavoritesUseCase,
        isFavoriteUseCase: IsFavoriteUseCase
    ) {
        self.screenState = .loading
        self.tappedCountry = tappedCountry
        self.countryDetail = nil
        self.getCountryDetailUseCase = getCountryDetailUseCase
        self.addToFavoritesUseCase = addToFavoritesUseCase
        self.removeFromFavoritesUseCase = removeFromFavoritesUseCase
        self.isFavoriteUseCase = isFavoriteUseCase
        self.addToFavoritesButtonIcon = "star"
    }

    private func checkFavoritesStatus() {
        let isFavorite = isFavoriteUseCase.execute(country: tappedCountry)
        addToFavoritesButtonIcon = isFavorite ? "star.fill" : "star"
    }

    func getCountryDetail() async {
        do {
            countryDetail = try await getCountryDetailUseCase.execute(countryName: tappedCountry.name)
            checkFavoritesStatus()
            screenState = .loaded
        } catch {
            print("Error Getting Country Detail - \(String(describing: error))")
            screenState = .error
        }
    }

    func addToFavoritesAction() {
        let isFavoriteCountry = isFavoriteUseCase.execute(country: tappedCountry)
        if isFavoriteCountry {
            removeFromFavoritesUseCase.execute(country: tappedCountry)
            addToFavoritesButtonIcon = "star"
        } else {
            addToFavoritesUseCase.execute(country: tappedCountry)
            addToFavoritesButtonIcon = "star.fill"
        }
    }
}

extension CountryDetailViewModel {
    enum ScreenState {
        case loading
        case loaded
        case error
    }
}
