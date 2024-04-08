//
//  Match.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 05/04/24.
//

import Foundation

class Match: Identifiable, Codable {
    let id: UUID
    var homeCompetitor: Competitor?
    var awayCompetitor: Competitor?
    var winner: Competitor?
    var date: Date?
    
    init(id: UUID, homeCompetitor: Competitor? = nil, awayCompetitor: Competitor? = nil, winner: Competitor? = nil, date: Date? = nil) {
        self.id = id
        self.homeCompetitor = homeCompetitor
        self.awayCompetitor = awayCompetitor
        self.winner = winner
        self.date = date
    }
}

// MARK: - Hashable

extension Match: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
    
    static func == (lhs: Match, rhs: Match) -> Bool {
        lhs.id == rhs.id
    }
}
