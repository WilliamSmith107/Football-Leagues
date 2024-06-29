//
//  HomeView.swift
//  Football-Leagues
//
//  Created by William Smith on 29/06/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel = ViewModel()
    
    var body: some View {

        VStack {
            
            HStack {
                Spacer()
                
                Picker("Year", selection: $viewModel.selectedYear) {
                    ForEach(viewModel.years, id: \.self) { year in
                        if (year == 2023) {
                            Text("\(year.description) (Current)")
                        } else{
                            Text("\(year.description)")
                        }
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            
            ScrollView {
                
                // Display all leagues in the API.
                ForEach(viewModel.leagues) { league in
                    
                    if (league.years != nil) {
                        if ((league.years!.contains(viewModel.selectedYear))) {
                            Text("\(league.name)")
                        }
                    }
                }
            }
        }
        .task {
            do {
                // First fetch all leagues.
                viewModel.leagues = try await viewModel.getLeagues()
                // Fetch and assign years with data for each league.
                try await viewModel.assignYears()
                
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
    HomeView()
}
