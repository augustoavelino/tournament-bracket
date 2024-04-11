//
//  Round.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import Foundation

struct Round: Codable, Identifiable {
    let id: UUID
    let index: Int
    var title: String?
    var matches: [Match]
    
    func isComplete() -> Bool {
        matches.filter({ $0.winner == nil }).isEmpty
    }
}

// MARK: - Comparable

extension Round: Comparable {
    static func == (lhs: Round, rhs: Round) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Round, rhs: Round) -> Bool {
        lhs.index <= rhs.index
    }
}
