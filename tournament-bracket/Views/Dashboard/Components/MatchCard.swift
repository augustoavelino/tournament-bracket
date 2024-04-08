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
    var homeColor: Color = .red
    var awayColor: Color = .blue
    var awayCompetitor: String = ""
    var date: Date?
    
    var body: some View {
        VStack(spacing: 0.0) {
            Rectangle()
                .fill(homeColor)
                .overlay {
                    SplitCardShape()
                        .fill(awayColor)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .overlay {
                    ZStack {
                        Text("X")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        VStack(spacing: 0.0) {
                            Text(homeCompetitor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            Text(awayCompetitor)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                }
            if let date = date {
                Text(date, style: .date)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.callout)
                    .padding(.vertical, 4.0)
            }
        }
        .frame(height: 160)
        .background(Color(white: 0.1), in: RoundedRectangle(cornerRadius: 25.0))
        .foregroundStyle(Color.white)
        .padding(.horizontal, 12)
    }
}

#Preview {
    MatchCard(homeCompetitor: "João Estrella", awayCompetitor: "Johnny", date: Date(timeIntervalSinceNow: -600000.0))
}
