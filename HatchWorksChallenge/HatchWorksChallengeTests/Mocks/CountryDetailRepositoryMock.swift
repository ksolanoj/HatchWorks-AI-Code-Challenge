//
//  CountryDetailRepositoryMock.swift
//  HatchWorksChallengeTests
//
//  Created by Kevin Solano Jiménez on 14/1/26.
//

@testable import HatchWorksChallenge
import Foundation

struct CountryDetailRepositoryMock: CountryDetailRepository {
    var result: Result<CountryDetail, Error>
    static let successResponse: CountryDetail = CountryDetail(
        name: "Costa Rica",
        officialName: "Republic of Costa Rica",
        flagPNG: URL(string: "https://example.com/cr.png"),
        capital: "San José",
        region: "Americas",
        subregion: "Central America",
        population: 5_200_000,
        area: 51_100,
        languages: ["Spanish"],
        timezones: ["UTC-06:00"],
        borders: ["NIC", "PAN"],
        mapsGoogle: URL(string: "https://maps.google.com/?q=Costa%20Rica"),
        mapsOSM: URL(string: "https://www.openstreetmap.org/search?query=Costa%20Rica")
    )

    init(
        result: Result<CountryDetail, Error> = .success(CountryDetailRepositoryMock.successResponse)
    ) {
        self.result = result
    }

    func getCountryDetail(name: String) async throws -> CountryDetail {
        switch result {
        case .success(let countryDetail):
            return countryDetail
        case .failure(let error):
            throw error
        }
    }
}
