//
//  CountriesListViewModel.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

@Observable
@MainActor
final class CountriesListViewModel {
    
    // Published Properties
    private(set) var screenState: ScreenState
    private(set) var filteredCountries: [Country]

    // Properties
    @ObservationIgnored
    private var allCountries: [Country]

    // UseCases
    @ObservationIgnored
    private let getCountriesUseCase: GetCountriesUseCase

    init(getCountriesUseCase: GetCountriesUseCase) {
        self.screenState = .loading
        self.filteredCountries = []
        self.allCountries = []
        self.getCountriesUseCase = getCountriesUseCase
    }

    func getCountries() async {
        do {
            let countries = try await getCountriesUseCase.execute()
            allCountries = countries
            filteredCountries = countries
            screenState = .loaded
        } catch {
            print("Error Getting Countries - \(String(describing: error))")
            screenState = .error
        }
    }
}

extension CountriesListViewModel {
    enum ScreenState {
        case loading
        case loaded
        case error
    }
}
