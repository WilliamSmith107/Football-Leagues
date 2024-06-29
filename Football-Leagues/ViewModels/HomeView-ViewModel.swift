//
//  HomeView-ViewModel.swift
//  Football-Leagues
//
//  Created by William Smith on 29/06/2024.
//

import Foundation

extension HomeView {
    @Observable
    class ViewModel {
        
        // Main league array for presentation.
        var leagues: [League] = [League]()
        
       
        
        
        
        // MARK: Async functions.
        // Fetch leagues from URL.
        func getLeagues() async throws -> [League] {
            
            let endpoint = "https://api-football-standings.azharimm.dev/leagues"
            
            guard let url = URL(string: endpoint) else { throw LError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw LError.invalidResponse
            }
            
            
            do {
                let decoder = JSONDecoder()
                
                let root = try decoder.decode(LeagueRoot.self, from: data)
                
                let out = root.data
                
                return out
            } catch {
                throw LError.invalidData
            }
        }
    }
}
