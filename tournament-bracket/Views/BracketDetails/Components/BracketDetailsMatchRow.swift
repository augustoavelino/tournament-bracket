//
//  BracketDetailsMatchRow.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 09/04/24.
//

import SwiftUI

// TODO: [IMPORTANT] Remove logic from component
struct BracketDetailsMatchRow: View {
    @State var match: Match
    var onSwipeAction: ((Match) -> Void)?
    private var shouldSwipe: Bool { match.homeCompetitor != nil && match.awayCompetitor != nil }
    
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
            homeWinnerButton
        }
        .swipeActions(edge: .trailing) {
            awayWinnerButton
        }
    }
    
    @ViewBuilder
    private var homeWinnerButton: some View {
        if shouldSwipe {
            Button(action: toggleHomeWinner, label: {
                Text("Winner")
            })
            .tint(.green)
        }
    }
    
    @ViewBuilder
    private var awayWinnerButton: some View {
        if shouldSwipe {
            Button(action: toggleAwayWinner, label: {
                Text("Winner")
            })
            .tint(.blue)
        }
    }
    
    // MARK: - Actions
    
    private func toggleHomeWinner() {
        if let winner = match.winner, winner == match.homeCompetitor {
            match.winner = nil
        } else {
            match.winner = match.homeCompetitor
        }
        onSwipeAction?(match)
    }
    
    private func toggleAwayWinner() {
        if let winner = match.winner, winner == match.awayCompetitor {
            match.winner = nil
        } else {
            match.winner = match.awayCompetitor
        }
        onSwipeAction?(match)
    }
}

#Preview {
    List(0..<1) { item in
        BracketDetailsMatchRow(
            match: Match(
                id: UUID(),
                homeCompetitor: Competitor(id: UUID(), name: "Home Team"),
                awayCompetitor: Competitor(id: UUID(), name: "Away Team"),
                date: Date()
            )
        )
    }
}
