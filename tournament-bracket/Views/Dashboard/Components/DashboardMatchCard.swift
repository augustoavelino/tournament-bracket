//
//  DashboardMatchCard.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import SwiftUI

struct DashboardMatchCard: View {
    var homeCompetitor: String = ""
    var homeColor: Color = .green
    var awayCompetitor: String = ""
    var awayColor: Color = .blue
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
                        Text("vs")
                            .font(.system(size: 40))
                            .fontWeight(.medium)
                            .fontWidth(.expanded)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 4.0)
                        VStack(spacing: 0.0) {
                            Text(homeCompetitor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title2)
                                .fontWeight(.bold)
                                .shadow(radius: 2, y: 2)
                            Spacer()
                            Text(awayCompetitor)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.title2)
                                .fontWeight(.bold)
                                .shadow(radius: 2, y: 2)
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
        .background(Color(white: 0.1), in: RoundedRectangle(cornerRadius: 25.0))
        .foregroundStyle(Color.white)
        .padding(.horizontal, 12)
    }
}

#Preview {
    DashboardMatchCard(homeCompetitor: "João Estrella", awayCompetitor: "Johnny", date: Date(timeIntervalSinceNow: -600000.0))
}
