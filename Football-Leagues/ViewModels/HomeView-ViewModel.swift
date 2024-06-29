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
        
       
        // MARK: Year picker variables.
        var selectedYear = 2023
        var years = [2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024]
        
        
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
        
        
        // Assign leagues their associated years.
        func assignYears() async throws {
            try await withThrowingTaskGroup(of: (String, [Int]).self) { taskGroup in
                
                for league in leagues {
                    taskGroup.addTask {
                        let years = try await self.getYears(id: league.id)
                        return(league.id, years)
                    }
                }
                
                for try await (id, years) in taskGroup {
                    if let index = leagues.firstIndex(where: { $0.id == id}) {
                        leagues[index].years = years
                    }
                }
            }
        }
        
        
        // Featch years associated with a season from ID.
        func getYears(id: String) async throws -> [Int] {
            
            let endpoint = "https://api-football-standings.azharimm.dev/leagues/\(id)/seasons"
            
            guard let url = URL(string: endpoint) else { throw LError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw LError.invalidResponse
            }
            
            
            do {
                let decoder = JSONDecoder()
                
                let root = try decoder.decode(YearsRoot.self, from: data)
                
                let seasons = root.data.seasons
                
                var out: [Int] = []
                
                for season in seasons {
                    if (season.types[0].hasStandings) {
                        out.append(season.year)
                    }
                }
                
                return out
            } catch {
                throw LError.invalidData
            }
            
        }
    }
}
