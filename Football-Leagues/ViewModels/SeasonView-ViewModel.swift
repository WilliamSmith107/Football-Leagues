//
//  SeasonView-ViewModel.swift
//  Football-Leagues
//
//  Created by William Smith on 29/06/2024.
//

import Foundation

extension SeasonView {
    @Observable
    class ViewModel {
        
        // Main season information for view.
        var season: Season = Season(name: "", abbreviation: "", seasonDisplay: "", season: 0, standings: [])
        
        // Variables for fetching season standings.
        var id: String
        var year: Int
        
        init(id: String, year: Int) {
            self.id = id
            self.year = year
        }
        
        
        // MARK: Async functions.
        // Fetch standings for the given league and season.
        func getStandings() async throws -> Season {
            
            let endpoint = "https://football-standings-api-pqotco6hc-azharimm.vercel.app/leagues/\(id)/standings?season=\(year.description)&sort=asc"

            
            print(endpoint)
            
            guard let url = URL(string: endpoint) else { throw LError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw LError.invalidResponse
            }
            
            
            do {
                let decoder = JSONDecoder()
                
                let root = try decoder.decode(SeasonRoot.self, from: data)
                
                let out = root.data
                
                
                return out
            } catch {
                print(error)
                throw LError.invalidData
            }
        }
    }
}
