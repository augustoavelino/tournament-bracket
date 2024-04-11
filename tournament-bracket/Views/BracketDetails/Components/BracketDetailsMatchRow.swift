//
//  BracketDetailsMatchRow.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 09/04/24.
//

import SwiftUI

struct BracketDetailsMatchRow: View {
    @State var match: Match
    var onSwipeAction: ((Match) -> Void)?
    
    var body: some View {
        HStack {
            HStack {
                Text(match.homeCompetitor?.name ?? "TBD (Home)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.center)
                if let winner = match.winner, winner == match.homeCompetitor {
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(.yellow)
                } else {
                    Image(systemName: "trophy")
                        .foregroundStyle(.green)
                }
            }
            Text("X")
            HStack {
                if let winner = match.winner, winner == match.awayCompetitor {
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(.yellow)
                } else {
                    Image(systemName: "trophy")
                        .foregroundStyle(.blue)
                }
                Text(match.awayCompetitor?.name ?? "TBD (Away)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.center)
            }
        }
        .swipeActions(edge: .leading) {
            Button("Winner") {
                print("Winner: Home")
                if let winner = match.winner, winner == match.homeCompetitor {
                    match.winner = nil
                } else {
                    match.winner = match.homeCompetitor
                }
                onSwipeAction?(match)
            }
            .tint(.green)
        }
        .swipeActions(edge: .trailing) {
            Button("Winner") {
                print("Winner: Away")
                if let winner = match.winner, winner == match.awayCompetitor {
                    match.winner = nil
                } else {
                    match.winner = match.awayCompetitor
                }
                onSwipeAction?(match)
            }
            .tint(.blue)
        }
    }
}

#Preview {
    List(0..<1) { item in
        BracketDetailsMatchRow(
            match: Match(id: UUID(), homeCompetitor: Competitor(id: UUID(), seed: 1, name: "Home Team"), awayCompetitor: Competitor(id: UUID(), seed: 2, name: "Away Team"), date: Date())
        )
    }
}
