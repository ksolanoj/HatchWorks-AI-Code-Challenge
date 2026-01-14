//
//  CountryDetail.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

struct CountryDetail: Identifiable, Hashable {
    let id: String

    let name: String
    let officialName: String
    let flagPNG: URL?

    let capital: String?
    let region: String?
    let subregion: String?
    let population: Int
    let area: Double?

    let languages: [String]

    let timezones: [String]
    let borders: [String]

    let mapsGoogle: URL?
    let mapsOSM: URL?

    init(
        name: String,
        officialName: String,
        flagPNG: URL?,
        capital: String?,
        region: String?,
        subregion: String?,
        population: Int,
        area: Double?,
        languages: [String],
        timezones: [String],
        borders: [String],
        mapsGoogle: URL?,
        mapsOSM: URL?
    ) {
        self.id = name
        self.name = name
        self.officialName = officialName
        self.flagPNG = flagPNG
        self.capital = capital
        self.region = region
        self.subregion = subregion
        self.population = population
        self.area = area
        self.languages = languages
        self.timezones = timezones
        self.borders = borders
        self.mapsGoogle = mapsGoogle
        self.mapsOSM = mapsOSM
    }
}
