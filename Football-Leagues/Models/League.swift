//
//  League.swift
//  Football-Leagues
//
//  Created by William Smith on 29/06/2024.
//

import Foundation

// Root of the leagues page, holds status.
struct LeagueRoot: Codable {
    let status: Bool
    let data: [League]
}

// League struct, holding league names and logos.
struct League: Codable, Identifiable {
    var years: [Int]?
    
    let id: String
    let name: String
    let slug: String
    let abbr: String
    let logos: LeagueLogos
}

// League logo URLs, holding light and dark mode logos.
struct LeagueLogos: Codable {
    let light: String
    let dark: String
}
