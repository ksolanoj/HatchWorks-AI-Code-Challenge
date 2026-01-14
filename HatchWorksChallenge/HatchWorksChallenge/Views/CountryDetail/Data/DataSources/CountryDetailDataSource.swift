//
//  CountryDetailDataSource.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

protocol CountryDetailDataSource {
    /// Function used to get the country detail DTO
    /// - Parameter name: Name of the country you want to get the detail from
    /// - Returns: Country Detail DTO
    func getCountryDetail(name: String) async throws -> CountryDetailDTO
}

struct CountryDetailDataSourceImpl: CountryDetailDataSource {
    func getCountryDetail(name: String) async throws -> CountryDetailDTO {
        let url = API.makeURL(.name(name))
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw RequestError.somethingWentWrong
        }

        let decodedResponse = try JSONDecoder().decode([CountryDetailDTO].self, from: data)

        guard let country = decodedResponse.first else {
            throw RequestError.somethingWentWrong
        }

        return country
    }
}
