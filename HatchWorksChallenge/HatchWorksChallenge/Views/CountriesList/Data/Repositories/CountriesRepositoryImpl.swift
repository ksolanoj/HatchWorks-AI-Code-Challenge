//
//  CountriesRepositoryImpl.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

struct CountriesRepositoryImpl: CountriesRepository {

    // DataSources
    private let countriesDataSource: CountriesDataSource

    init(
        countriesDataSource: CountriesDataSource = CountriesDataSourceImpl()
    ) {
        self.countriesDataSource = countriesDataSource
    }

    func getCountries() async throws -> [Country] {
        let countryDTOs = try await countriesDataSource.getCountries()
        let finalCountryObjects = countryDTOs.map { $0.toDomain() }
        return finalCountryObjects
    }
}
