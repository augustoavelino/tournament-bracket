//
//  BracketDetailsView.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import SwiftData
import SwiftUI

struct BracketDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var bracket: Bracket
    
    var body: some View {
        let rounds = bracket.rounds.sorted()
        VStack {
            List {
                ForEach(rounds) { round in
                    Section {
                        ForEach(round.matches) { match in
                            BracketDetailsMatchRow(match: match) { resultMatch in
                                guard let roundIndex = rounds.firstIndex(of: round),
                                      let matchIndex = round.matches.firstIndex(of: match) else { return }
                                bracket.updateMatch(resultMatch, atIndex: matchIndex, roundIndex: roundIndex)
                            }
                        }
                    } header: {
                        Text(title(for: round))
                    }
                    .alignmentGuide(.listRowSeparatorLeading, computeValue: { d in
                        // TODO: Fix this later
                        return d[.leading] - 16
                    })
                }
            }
        }
        .navigationTitle(bracket.title)
    }
    
    func title(for round: Round) -> String {
        if let roundTitle = round.title { return roundTitle }
        if round.index == bracket.rounds.count { return String(localized: "Final") }
        let formatter = TBNumberFormatter()
        formatter.numberStyle = .ordinal
        let roundIndex = NSNumber(value: round.index)
        if let ordinal = formatter.string(from: roundIndex, altOrdinal: true) {
            return "\(ordinal) \(String(localized: "Round"))"
        }
        return "\(String(localized: "Round")) \(round.index)"
    }
    
    func title(for competitor: Competitor?, isHomeCompetitor: Bool = true) -> String {
        if let competitorName = competitor?.name { return competitorName }
        return isHomeCompetitor ? "TBD (Home)" : "TBD (Away)"
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Bracket.self, configurations: config)
    let context = ModelContext(container)
    let bracket = Bracket(id: UUID(), title: "1st Tournament", competitors: [
        Competitor(id: UUID(), name: "Testando"),
        Competitor(id: UUID(), name: "Outro Teste"),
        Competitor(id: UUID(), name: "Mais um teste"),
        Competitor(id: UUID(), name: "Ainda mais um teste"),
    ])
    context.insert(bracket)
    return NavigationStack {
        BracketDetailsView()
            .modelContext(context)
            .environmentObject(bracket)
    }
    .toolbarTitleDisplayMode(.large)
}
