//
//  CountryDetailDTO.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

// MARK: - Root

struct CountryDetailDTO: Codable {
    let name: DetailNameDTO
    let tld: [String]?
    let cca2: String?
    let ccn3: String?
    let cioc: String?
    let independent: Bool?
    let status: String?
    let unMember: Bool?
    let currencies: [String: CurrencyDTO]?
    let idd: IddDTO?
    let capital: [String]?
    let altSpellings: [String]?
    let region: String?
    let subregion: String?
    let languages: [String: String]?
    let latlng: [Double]?
    let landlocked: Bool?
    let borders: [String]?
    let area: Double?
    let demonyms: [String: DemonymDTO]?
    let cca3: String?
    let translations: [String: TranslationDTO]?
    let flag: String?
    let maps: MapsDTO?
    let population: Int?
    let gini: [String: Double]?
    let fifa: String?
    let car: CarDTO?
    let timezones: [String]?
    let continents: [String]?
    let flags: DetailFlagsDTO
    let coatOfArms: CoatOfArmsDTO?
    let startOfWeek: String?
    let capitalInfo: CapitalInfoDTO?
    let postalCode: PostalCodeDTO?

    func toDomain() -> CountryDetail {
        return CountryDetail(
            name: name.common,
            officialName: name.official,
            flagPNG: URL(string: flags.png),
            capital: capital?.first,
            region: region,
            subregion: subregion,
            population: population ?? 0,
            area: area,
            languages: languages?.values.sorted() ?? [],
            timezones: timezones ?? [],
            borders: borders ?? [],
            mapsGoogle: URL(string: maps?.googleMaps ?? ""),
            mapsOSM: URL(string: maps?.openStreetMaps ?? "")
        )
    }
}

// MARK: - Name

struct DetailNameDTO: Codable {
    let common: String
    let official: String
    let nativeName: [String: DetailNativeNameDTO]?
}

struct DetailNativeNameDTO: Codable {
    let official: String
    let common: String
}

// MARK: - Currencies

struct CurrencyDTO: Codable {
    let symbol: String?
    let name: String?
}

// MARK: - IDD

struct IddDTO: Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Demonyms

struct DemonymDTO: Codable {
    let f: String?
    let m: String?
}

// MARK: - Translations

struct TranslationDTO: Codable {
    let official: String?
    let common: String?
}

// MARK: - Maps

struct MapsDTO: Codable {
    let googleMaps: String?
    let openStreetMaps: String?
}

// MARK: - Car

struct CarDTO: Codable {
    let signs: [String]?
    let side: String?
}

// MARK: - Flags & Coat of Arms

struct DetailFlagsDTO: Codable {
    let png: String
    let svg: String
    let alt: String?
}

struct CoatOfArmsDTO: Codable {
    let png: String?
    let svg: String?
}

// MARK: - Capital info

struct CapitalInfoDTO: Codable {
    let latlng: [Double]?
}

// MARK: - Postal code

struct PostalCodeDTO: Codable {
    let format: String?
    let regex: String?
}
