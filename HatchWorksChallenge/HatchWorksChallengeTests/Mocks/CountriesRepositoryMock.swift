//
//  CountriesRepositoryMock.swift
//  HatchWorksChallengeTests
//
//  Created by Kevin Solano Jiménez on 14/1/26.
//

@testable import HatchWorksChallenge
import Foundation

struct CountriesRepositoryMock: CountriesRepository {
    var result: Result<[Country], Error>
    static let successResponse: [Country] = [
        Country(name: "Costa Rica", flagURL: URL(string: "https://example.com/cr.png"), population: 5_200_000),
        Country(name: "Japan", flagURL: URL(string: "https://example.com/jp.png"), population: 125_000_000),
        Country(name: "Canada", flagURL: URL(string: "https://example.com/ca.png"), population: 40_000_000)
    ]

    init(
        result: Result<[Country], Error> = .success(CountriesRepositoryMock.successResponse)
    ) {
        self.result = result
    }

    func getCountries() async throws -> [Country] {
        switch result {
        case .success(let countries):
            return countries
        case .failure(let error):
            throw error
        }
    }
}
