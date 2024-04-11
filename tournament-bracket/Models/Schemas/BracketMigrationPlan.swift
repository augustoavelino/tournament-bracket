//
//  BracketMigrationPlan.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 11/04/24.
//

import Foundation
import SwiftData

enum BracketMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [
            VersionedSchemaV1.self,
            VersionedSchemaV2.self
        ]
    }
    
    static var stages: [MigrationStage] {
        [
            migrateV1toV2
        ]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: VersionedSchemaV1.self,
        toVersion: VersionedSchemaV2.self, willMigrate: { context in
            do {
                let items = try context.fetch(FetchDescriptor<Bracket>())
                items.forEach({ bracket in
                    for (itemIndex, competitor) in bracket.competitors.enumerated() {
                        let updated = Competitor(id: competitor.id, seed: itemIndex + 1, name: competitor.name)
                        bracket.saveCompetitor(updated)
                    }
                    for (roundIndex, round) in bracket.rounds.enumerated() {
                        for (matchIndex, match) in round.matches.enumerated() {
                            var updatedHome: Competitor?
                            var updatedAway: Competitor?
                            var updatedWinner: Competitor?
                            if let homeCompetitor = match.homeCompetitor,
                               let homeRef = bracket.competitors.first(where: { $0.id == homeCompetitor.id }) {
                                updatedHome = homeRef
                            }
                            if let awayCompetitor = match.awayCompetitor,
                               let awayRef = bracket.competitors.first(where: { $0.id == awayCompetitor.id }) {
                                updatedAway = awayRef
                            }
                            if let winner = match.winner,
                               let winnerRef = bracket.competitors.first(where: { $0.id == winner.id }) {
                                updatedWinner = winnerRef
                            }
                            let updatedMatch = Match(id: match.id, homeCompetitor: updatedHome, awayCompetitor: updatedAway, winner: updatedWinner, date: match.date)
                            bracket.updateMatch(match, atIndex: matchIndex, roundIndex: roundIndex)
                        }
                    }
                })
                try context.save()
            } catch {
                debugPrint(error)
            }
        }, didMigrate: nil)
}
