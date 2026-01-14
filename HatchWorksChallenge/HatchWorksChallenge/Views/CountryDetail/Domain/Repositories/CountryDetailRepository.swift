//
//  CountryDetailRepository.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

protocol CountryDetailRepository {
    /// Function used to get the detail information of a country
    /// - Parameter name: Name of the country you want to get the info
    /// - Returns: Country Detail Object
    func getCountryDetail(name: String) async throws -> CountryDetail
}
