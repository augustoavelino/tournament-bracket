//
//  Match.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 05/04/24.
//

import Foundation

struct Match: Codable, Identifiable {
    let id: UUID
    var homeCompetitor: Competitor?
    var awayCompetitor: Competitor?
    var winner: Competitor?
    var date: Date?
}

// MARK: - Hashable

extension Match: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id.uuidString)
    }
}
