//
//  MatchCard.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import SwiftUI

struct MatchCard: View {
    var color: Color = .accentColor
    var homeCompetitor: String = ""
    var awayCompetitor: String = ""
    var date: Date?
    
    var body: some View {
        VStack(spacing: 0.0) {
            Text(homeCompetitor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            Spacer()
            Text("X")
                .font(.title2)
            Spacer()
            Text(awayCompetitor)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.title)
            if let date = date {
                Text(date, style: .date)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.caption)
                    .padding(.top, 4.0)
            }
        }
        .padding()
        .frame(height: 192)
        .background(color, in: RoundedRectangle(cornerRadius: 25.0))
        .foregroundStyle(Color.white)
        .padding(.horizontal, 12)
    }
}

#Preview {
    MatchCard(homeCompetitor: "João Estrella", awayCompetitor: "Johnny", date: Date(timeIntervalSinceNow: -600000.0))
}
