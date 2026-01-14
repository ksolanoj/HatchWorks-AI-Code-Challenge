//
//  CountryDetailViewModel.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

@Observable
@MainActor
final class CountryDetailViewModel {

    // Published Properties
    private(set) var screenState: ScreenState

    // Properties
    @ObservationIgnored
    private(set) var tappedCountry: Country
    @ObservationIgnored
    private(set) var countryDetail: CountryDetail?

    // UseCases
    @ObservationIgnored
    private let getCountryDetailUseCase: GetCountryDetailUseCase

    init(
        tappedCountry: Country,
        getCountryDetailUseCase: GetCountryDetailUseCase
    ) {
        self.screenState = .loading
        self.tappedCountry = tappedCountry
        self.countryDetail = nil
        self.getCountryDetailUseCase = getCountryDetailUseCase
    }

    func getCountryDetail() async {
        do {
            countryDetail = try await getCountryDetailUseCase.execute(countryName: tappedCountry.name)
            screenState = .loaded
        } catch {
            print("Error Getting Country Detail - \(String(describing: error))")
            screenState = .error
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
