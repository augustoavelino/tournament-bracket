//
//  BracketTests.swift
//  tournament-bracketTests
//
//  Created by Augusto Avelino on 05/04/24.
//

import XCTest
import SwiftData
@testable import tournament_bracket

final class BracketTests: XCTestCase {
    let competitorPool: [Competitor] = [
        Competitor(id: UUID(), name: "Team 1"),
        Competitor(id: UUID(), name: "Team 2"),
        Competitor(id: UUID(), name: "Team 3"),
        Competitor(id: UUID(), name: "Team 4"),
        Competitor(id: UUID(), name: "Team 5"),
        Competitor(id: UUID(), name: "Team 6"),
        Competitor(id: UUID(), name: "Team 7"),
        Competitor(id: UUID(), name: "Team 8"),
        Competitor(id: UUID(), name: "Team 9"),
        Competitor(id: UUID(), name: "Team 10"),
        Competitor(id: UUID(), name: "Team 11"),
        Competitor(id: UUID(), name: "Team 12"),
        Competitor(id: UUID(), name: "Team 13"),
        Competitor(id: UUID(), name: "Team 14"),
        Competitor(id: UUID(), name: "Team 15"),
        Competitor(id: UUID(), name: "Team 16"),
    ]
    
    func test_generateRounds_shouldGenerateCorrectAmountOfRounds() {
        let bracket2 = Bracket(id: UUID(), title: "2 Competitors", competitors: randomCompetitors(2), generateAutomatically: false)
        let bracket2Rounds = bracket2.generateRounds()
        XCTAssertEqual(bracket2Rounds.count, 1)
        
        let bracket4 = Bracket(id: UUID(), title: "4 Competitors", competitors: randomCompetitors(4), generateAutomatically: false)
        let bracket4Rounds = bracket4.generateRounds()
        XCTAssertEqual(bracket4Rounds.count, 2)
        
        let bracket8 = Bracket(id: UUID(), title: "8 Competitors", competitors: randomCompetitors(8), generateAutomatically: false)
        let bracket8Rounds = bracket8.generateRounds()
        XCTAssertEqual(bracket8Rounds.count, 3)
        
        let bracket16 = Bracket(id: UUID(), title: "16 Competitors", competitors: randomCompetitors(16), generateAutomatically: false)
        let bracket16Rounds = bracket16.generateRounds()
        XCTAssertEqual(bracket16Rounds.count, 4)
    }
    
    func test_generateRounds_shouldGenerateRoundsInCorrectOrder() {
        let bracket4 = Bracket(id: UUID(), title: "4 Competitors", competitors: randomCompetitors(4), generateAutomatically: false)
        let bracket4Rounds = bracket4.generateRounds()
        XCTAssertEqual(bracket4Rounds.count, 2)
        XCTAssertEqual(bracket4Rounds[0].matches.count, 2)
        XCTAssertEqual(bracket4Rounds[1].matches.count, 1)
        
        let bracket8 = Bracket(id: UUID(), title: "8 Competitors", competitors: randomCompetitors(8), generateAutomatically: false)
        let bracket8Rounds = bracket8.generateRounds()
        XCTAssertEqual(bracket8Rounds.count, 3)
        XCTAssertEqual(bracket8Rounds[0].matches.count, 4)
        XCTAssertEqual(bracket8Rounds[1].matches.count, 2)
        XCTAssertEqual(bracket8Rounds[2].matches.count, 1)
        
        let bracket16 = Bracket(id: UUID(), title: "16 Competitors", competitors: randomCompetitors(16), generateAutomatically: false)
        let bracket16Rounds = bracket16.generateRounds()
        XCTAssertEqual(bracket16Rounds.count, 4)
        XCTAssertEqual(bracket16Rounds[0].matches.count, 8)
        XCTAssertEqual(bracket16Rounds[1].matches.count, 4)
        XCTAssertEqual(bracket16Rounds[2].matches.count, 2)
        XCTAssertEqual(bracket16Rounds[3].matches.count, 1)
    }
    
    func test_reloadBracket_withInitialCompetitorsAndGenerateAutomaticallyTrue_shouldStoreGeneratedRounds() {
        let competitors = randomCompetitors(8)
        let bracket = Bracket(id: UUID(), title: "Tournament", competitors: competitors)
        XCTAssertEqual(bracket.rounds.count, 3)
    }
    
    func test_reloadBracket_shouldGenerateCorrectAmountOfMatches() {
        let bracket2 = Bracket(id: UUID(), title: "2 Competitors", competitors: randomCompetitors(2))
        let bracket2Matches = bracket2.matches
        XCTAssertEqual(bracket2Matches.count, 1)
        
        let bracket4 = Bracket(id: UUID(), title: "4 Competitors", competitors: randomCompetitors(4))
        let bracket4Matches = bracket4.matches
        XCTAssertEqual(bracket4Matches.count, 3)
        
        let bracket8 = Bracket(id: UUID(), title: "8 Competitors", competitors: randomCompetitors(8))
        let bracket8Matches = bracket8.matches
        XCTAssertEqual(bracket8Matches.count, 7)
        
        let bracket16 = Bracket(id: UUID(), title: "16 Competitors", competitors: randomCompetitors(16))
        let bracket16Matches = bracket16.matches
        XCTAssertEqual(bracket16Matches.count, 15)
    }
    
    // MARK: - Helpers
    
    private func randomCompetitors(_ count: Int) -> [Competitor] {
        return Array(competitorPool.shuffled()[0..<count])
    }
}
