//
//  Bracket.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 05/04/24.
//

import Foundation
import SwiftData

@Model
class Bracket: Identifiable {
    let id: UUID
    var title: String
    private(set) var competitors: [Competitor]
    private(set) var rounds: [Round] = []
    var matches: [Match] { rounds.flatMap { $0.matches } }
    
    init(id: UUID, title: String, competitors: [Competitor], generateAutomatically: Bool = true) {
        self.id = id
        self.title = title
        self.competitors = competitors
        if generateAutomatically {
            reloadBracket()
        }
    }
    
    func reloadBracket() {
        guard !competitors.isEmpty else { return rounds = [] }
        rounds = generateRounds()
    }
    
    func generateRounds() -> [Round] {
        var resultRounds: [Round] = []
        let numRounds = numberOfRounds(for: competitors.count)
        var competitorQueue = competitors.shuffled()
        
        // Generate matches for each round
        for round in 0..<numRounds {
            var roundMatches: [Match] = []
            for _ in 0..<max(Int(pow(2.0, Double(numRounds - round - 1))), 1) {
                roundMatches.append(Match(id: UUID(), homeCompetitor: competitorQueue.popLast(), awayCompetitor: competitorQueue.popLast()))
            }
            resultRounds.append(Round(id: UUID(), index: round + 1, matches: roundMatches))
        }
        return resultRounds
    }
    
    func saveCompetitor(_ competitor: Competitor) {
        if let competitorIndex = competitors.firstIndex(where: { $0.id == competitor.id }) {
            competitors[competitorIndex] = competitor
        } else {
            competitors.append(competitor)
        }
    }
    
    @discardableResult
    func removeCompetitor(withID competitorID: UUID) -> Competitor? {
        if let competitorIndex = competitors.firstIndex(where: { $0.id == competitorID }) {
            return competitors.remove(at: competitorIndex)
        }
        return nil
    }
    
    /// Calculates the number of rounds based on the number of competitors
    private func numberOfRounds(for numCompetitors: Int) -> Int {
        Int(log2(Double(numCompetitors)))
    }
}
