//
//  BracketDetailsView+ViewModel.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import SwiftData
import SwiftUI

extension BracketDetailsView {
    class ViewModel: ObservableObject {
        let modelContext: ModelContext
        @Published private(set) var bracket: Bracket
        
        init(modelContext: ModelContext, bracket: Bracket) {
            self.modelContext = modelContext
            self.bracket = bracket
        }
        
        func title(for round: Round) -> String {
            if let roundTitle = round.title { return roundTitle }
            if round.index == bracket.rounds.count { return String(localized: "Final") }
            let formatter = TBNumberFormatter()
            formatter.numberStyle = .ordinal
            let roundIndex = NSNumber(value: round.index)
            if let ordinal = formatter.string(from: roundIndex, altOrdinal: true) {
                return "\(ordinal) \(String(localized: "Round"))"
            }
            return "\(String(localized: "Round")) \(round.index)"
        }
        
        func title(for match: Match) -> String {
            let homeCompetitor = match.homeCompetitor?.name ?? "TBD (Home)"
            let awayCompetitor = match.awayCompetitor?.name ?? "TBD (Away)"
            return "\(homeCompetitor) X \(awayCompetitor)"
        }
    }
}
