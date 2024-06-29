//
//  Season.swift
//  Football-Leagues
//
//  Created by William Smith on 29/06/2024.
//

import Foundation

struct SeasonRoot: Codable {
    let status: Bool
    let data: Season
}


struct Season: Codable {
    
    let name: String
    let abbreviation: String
    let seasonDisplay: String
    let season: Int
    let standings: [Standings]
}


struct Standings: Codable, Identifiable {
    var id = UUID()
    
    let team: Team
    let note: Note?
    let stats: [Stats]
    
    private enum CodingKeys: String, CodingKey {
        case team, note, stats
    }
}


struct Team: Codable, Identifiable {
    let id: String
    let uid: String
    let location: String
    let name: String
    let abbreviation: String?
    let displayName: String
    let shortDisplayName: String
    let isActive: Bool
    let logos: [TeamLogos]?
    let isNational: Bool
}


struct TeamLogos: Codable {
    let href: String
    let width: Int
    let height: Int
    let alt: String
    let rel: [String]
    let lastUpdated: String
}


struct Note: Codable {
    let color: String
    let description: String
    let rank: Int
}


struct Stats: Codable {
    let name: String
    let displayName: String
    let shortDisplayName: String
    let description: String
    let abbreviation: String?
    let type: String
    let value: Int?
    let displayValue: String
    
    let id: String?
    let summary: String?
}


