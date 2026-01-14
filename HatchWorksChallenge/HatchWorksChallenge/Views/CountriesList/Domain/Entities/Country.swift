//
//  Country.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

struct Country: Identifiable, Hashable {
    let id: String
    let name: String
    let flagURL: URL?
    let population: Int

    init(name: String, flagURL: URL?, population: Int) {
        self.id = name
        self.name = name
        self.flagURL = flagURL
        self.population = population
    }
}
