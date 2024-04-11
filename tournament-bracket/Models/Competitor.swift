//
//  Competitor.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 05/04/24.
//

import Foundation

struct Competitor: Codable, Equatable, Identifiable {
    let id: UUID
    var seed: Int
    var name: String
}
