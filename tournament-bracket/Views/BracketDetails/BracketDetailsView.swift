//
//  BracketDetailsView.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import SwiftData
import SwiftUI

struct BracketDetailsView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.bracket.rounds.sorted()) { round in
                    Section {
                        ForEach(round.matches) { match in
                            Text(viewModel.title(for: match))
                        }
                    } header: {
                        Text(viewModel.title(for: round))
                    }
                }
            }
        }
        .navigationTitle(viewModel.bracket.title)
    }
    
    init(modelContext: ModelContext, bracket: Bracket) {
        self.viewModel = ViewModel(modelContext: modelContext, bracket: bracket)
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
        BracketDetailsView(modelContext: context, bracket: bracket)
    }
    .toolbarTitleDisplayMode(.large)
}
