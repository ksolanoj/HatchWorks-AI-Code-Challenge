//
//  File.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

struct GetCountriesUseCase {

    // Repositories
    private let countriesRepository: CountriesRepository

    init(
        countriesRepository: CountriesRepository = CountriesRepositoryImpl()
    ) {
        self.countriesRepository = countriesRepository
    }

    func execute() async throws -> [Country] {
        return try await countriesRepository.getCountries()
    }
}
