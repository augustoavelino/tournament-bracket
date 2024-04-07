//
//  NewBracketView+ViewModel.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import Foundation
import SwiftData

extension NewBracketView {
    class ViewModel: ObservableObject {
        let modelContext: ModelContext
        @Published var tournamentName: String = ""
        @Published var competitors: [Competitor] = []
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }
        
        func addCompetitor(named competitorName: String) {
            let competitor = Competitor(id: UUID(), name: competitorName)
            competitors.append(competitor)
        }
        
        func canSaveTournament() -> Bool {
            !tournamentName.isEmpty && competitors.count > 1
        }
        
        func saveTournament() {
            let tournament = Bracket(id: UUID(), title: tournamentName, competitors: competitors)
            modelContext.insert(tournament)
            if modelContext.hasChanges {
                do {
                    try modelContext.save()
                } catch {
                    debugPrint(error)
                }
            }
        }
    }
}
