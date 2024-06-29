//
//  SeasonView.swift
//  Football-Leagues
//
//  Created by William Smith on 29/06/2024.
//

import SwiftUI

struct SeasonView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: ViewModel
    
    init(id: String, year: Int) {
        viewModel = ViewModel(id: id, year: year)
    }
    

    var body: some View {
        
        NavigationStack {
            VStack {
                HStack(spacing: 5) {
                    Text("Club")
                        .frame(width: 180, alignment: .leading)
                    
                    Spacer()
                    
                    Text("MP")
                        .frame(width: 25, alignment: .center)
                    Text("W")
                        .frame(width: 25, alignment: .center)
                    Text("D")
                        .frame(width: 25, alignment: .center)
                    Text("L")
                        .frame(width: 25, alignment: .center)
                    Text("Pts")
                        .frame(width: 25, alignment: .center)
                }
                .padding(.horizontal)
                    .foregroundStyle(.secondary)
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.season.standings, id: \.team.id) { standing in
                            
                            StandingRow(standing: standing)
                            
                        }
                    }
                }
                
            }
            .navigationTitle("\(viewModel.season.name)")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
        .task {
            do {
                viewModel.season = try await viewModel.getStandings()
            } catch LError.invalidURL {
                print("Invalid URL.")
            } catch LError.invalidResponse {
                print("Invalid response.")
            } catch LError.invalidData {
                print("Invalid data.")
            } catch {
                print("Unexpected error.")
            }
        }
    }
}

#Preview {
    SeasonView(id: "eng.1", year: 2023)
}
