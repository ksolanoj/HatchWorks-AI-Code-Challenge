//
//  CountriesDataSource.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

protocol CountriesDataSource {
    /// Function to get the countries from the API
    /// - Returns: List of Countries DTOs
    func getCountries() async throws -> [CountryDTO]
}

struct CountriesDataSourceImpl: CountriesDataSource {
    func getCountries() async throws -> [CountryDTO] {
        let url = API.makeURL(.all(fields: [.name, .flags, .continents, .population]))
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw RequestError.somethingWentWrong
        }

        let countries = try JSONDecoder().decode([CountryDTO].self, from: data)

        return countries
    }
}
