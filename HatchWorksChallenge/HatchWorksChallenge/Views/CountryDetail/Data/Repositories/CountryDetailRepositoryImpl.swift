//
//  CountryDetailRepositoryImpl.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

struct CountryDetailRepositoryImpl: CountryDetailRepository {

    // Data Sources
    private let countryDetailDataSource: CountryDetailDataSource

    init(
        countryDetailDataSource: CountryDetailDataSource = CountryDetailDataSourceImpl()
    ) {
        self.countryDetailDataSource = countryDetailDataSource
    }

    func getCountryDetail(name: String) async throws -> CountryDetail {
        let countryDetailDTO = try await countryDetailDataSource.getCountryDetail(name: name)
        let finalCountry = countryDetailDTO.toDomain()
        return finalCountry
    }
}
