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
            
            ScrollView {
                
                // Display all leagues in the API.
                ForEach(viewModel.leagues) { league in
                    Text("\(league.name)")
                }
            }
        }
        .task {
            do {
                
                viewModel.leagues = try await viewModel.getLeagues()
                
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
