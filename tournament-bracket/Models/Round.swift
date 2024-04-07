//
//  Round.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import Foundation

class Round: Identifiable, Codable {
    let id: UUID
    let index: Int
    var title: String?
    var matches: [Match]
    
    init(id: UUID, index: Int, title: String? = nil, matches: [Match]) {
        self.id = id
        self.index = index
        self.title = title
        self.matches = matches
    }
}

extension Round: Comparable {
    static func == (lhs: Round, rhs: Round) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Round, rhs: Round) -> Bool {
        lhs.index <= rhs.index
    }
}
