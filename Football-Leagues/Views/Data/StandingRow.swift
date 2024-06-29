//
//  StandingRow.swift
//  Football-Leagues
//
//  Created by William Smith on 29/06/2024.
//

import SwiftUI

struct StandingRow: View {
    
    var standing: Standings
    
    var body: some View {
        HStack(spacing: 5) {
            HStack {
                Text("\(standing.stats[10].displayValue)")
                    .frame(width: 25, alignment: .center)
                
                AsyncImage(url: URL(string: "\(standing.team.logos?[0].href ?? "https://png.pngtree.com/element_our/png/20181205/question-mark-vector-icon-png_256683.jpg")")) { image in
                    image.resizable()
                } placeholder: {
                    Circle()
                }
                .frame(width: 30, height: 30)
                
                Text("\(standing.team.shortDisplayName)")
            }
            .frame(width: 180, alignment: .leading)
            
            Spacer()
            
            Text("\(standing.stats[0].displayValue)")
                .frame(width: 25, alignment: .center)
            Text("\(standing.stats[7].displayValue)")
                .frame(width: 25, alignment: .center)
            Text("\(standing.stats[6].displayValue)")
                .frame(width: 25, alignment: .center)
            Text("\(standing.stats[1].displayValue)")
                .frame(width: 25, alignment: .center)
            Text("\(standing.stats[3].displayValue)")
                .frame(width: 25, alignment: .center)
        }.padding(.horizontal)
    }
}
