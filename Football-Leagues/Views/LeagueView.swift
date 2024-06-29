//
//  LeagueView.swift
//  Football-Leagues
//
//  Created by William Smith on 29/06/2024.
//

import SwiftUI

struct LeagueView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var league: League
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .circular)
                .foregroundStyle(.ultraThinMaterial)
            
            VStack {
                HStack {
                    AsyncImage(url: URL(string: "\(colorScheme == .dark ? "\(league.logos.dark)" : "\(league.logos.light)")")) { image in
                        image.resizable()
                    } placeholder: {
                        Circle()
                    }
                    .frame(width: 50, height: 50)
                }
                HStack {
                    Text("\(league.name)")
                        .multilineTextAlignment(.center)
                }
            }
            .padding(7.5)
        }
    }
}

#Preview {
    LeagueView(league: League(id: "eng.1", name: "Test League", slug: "", abbr: "TEST", logos: LeagueLogos(light: "", dark: "")))
}
