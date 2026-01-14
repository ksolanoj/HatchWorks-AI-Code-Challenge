//
//  CountryDTO.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

struct CountryDTO: Codable {
    let flags: FlagsDTO
    let name: NameDTO
    let population: Int
    let continents: [String]

    func toDomain() -> Country {
        return Country(
            name: name.official,
            flagURL: URL(string: flags.png),
            population: population
        )
    }
}

struct FlagsDTO: Codable {
    let png: String
    let svg: String
    let alt: String?
}

struct NameDTO: Codable {
    let common: String
    let official: String
    let nativeName: [String: NativeNameDTO]?
}

struct NativeNameDTO: Codable {
    let official: String
    let common: String
}
