//
//  Years.swift
//  Football-Leagues
//
//  Created by William Smith on 29/06/2024.
//

import Foundation

struct YearsRoot: Codable {
    let status: Bool
    let data: Years
}


struct Years: Codable {
    let name: String
    let desc: String
    let abbreviation: String
    let seasons: [YearsSeason]
}


struct YearsSeason: Codable {
    let year: Int
    let startDate: String
    let endDate: String
    let displayName: String
    let types: [YearsTypes]
}


struct YearsTypes: Codable {
    let id: String
    let name: String
    let abbreviation: String
    let startDate: String
    let endDate: String
    let hasStandings: Bool
}
