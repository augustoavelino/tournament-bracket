//
//  Competitor.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 05/04/24.
//

import Foundation

class Competitor: Identifiable, Codable {
    let id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
