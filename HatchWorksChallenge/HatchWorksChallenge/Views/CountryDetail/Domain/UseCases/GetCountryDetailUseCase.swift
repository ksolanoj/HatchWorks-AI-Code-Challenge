//
//  GetCountryDetailUseCase.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

struct GetCountryDetailUseCase {
    
    // Repositories
    private let countryDetailRepository: CountryDetailRepository

    init(
        countryDetailRepository: CountryDetailRepository = CountryDetailRepositoryImpl()
    ) {
        self.countryDetailRepository = countryDetailRepository
    }

    func execute(countryName: String) async throws -> CountryDetail {
        return try await countryDetailRepository.getCountryDetail(name: countryName)
    }
}
