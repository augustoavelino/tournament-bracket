//
//  DashboardView+ViewModel.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 05/04/24.
//

import SwiftUI
import SwiftData

extension DashboardView {
    class ViewModel: ObservableObject {
        let modelContext: ModelContext
        @Published private(set) var brackets: [Bracket] = []
        @Published private(set) var nextMatches: [Match] = []
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }
        
        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Bracket>(sortBy: [SortDescriptor(\.title)])
                brackets = try modelContext.fetch(descriptor)
                reloadNextMatches()
            } catch {
                debugPrint(error)
            }
        }
        
        func addBracket(_ bracket: Bracket) {
            modelContext.insert(bracket)
            fetchData()
        }
        
        func title(for match: Match) -> String {
            let homeCompetitor = match.homeCompetitor?.name ?? "TBD (Home)"
            let awayCompetitor = match.awayCompetitor?.name ?? "TBD (Away)"
            return "\(homeCompetitor) X \(awayCompetitor)"
        }
        
        func deleteBrackets(at offsets: IndexSet) {
            for index in offsets {
                modelContext.delete(brackets[index])
            }
            fetchData()
        }
        
        func reloadNextMatches() {
            let matches = brackets
                .map { sortMatches($0.matches, maxCount: 3) }
                .flatMap { $0 }
            nextMatches = matches
        }
        
        private func sortMatches(_ matchesToSort: [Match], maxCount: Int) -> [Match] {
            let amount = max(0, min(matchesToSort.count, maxCount))
            let sortedMatches = matchesToSort
                .sorted(by: { ($0.date ?? Date()) < ($1.date ?? Date()) })
            return Array(sortedMatches[0..<amount])
        }
    }
}
