//
//  CountriesRepository.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

protocol CountriesRepository {
    
    /// Function used to fetch Countries data from the server
    /// - Returns: List of Country Objects
    func getCountries() async throws -> [Country]
}
