//
//  NewBracketView.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import SwiftData
import SwiftUI

struct NewBracketView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var tournamentName = ""
    @State private var competitors: [Competitor] = []
    @State private var isPresentingAlert = false
    @State private var newCompetitorName: String = ""
    
    var body: some View {
        VStack(spacing: 0.0) {
            VStack(spacing: 0.0) {
                TextField("Tournament", text: $tournamentName)
                    .font(.title)
                Divider()
                    .padding(.top, 8.0)
            }
            VStack {
                List {
                    Section {
                        ForEach(competitors) { competitor in
                            Text(competitor.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 8.0)
                        }
                    } header: {
                        Text("Competitors")
                    }
                }
                .listStyle(.inset)
                Button("Add Competitor", systemImage: "plus.circle") {
                    newCompetitorName = ""
                    isPresentingAlert = true
                }
                .alert("New Competitor", isPresented: $isPresentingAlert) {
                    TextField("Name", text: $newCompetitorName)
                    Button("Add") {
                        addCompetitor(named: newCompetitorName)
                        isPresentingAlert = false
                    }
                    Button("Cancel", role: .cancel) {
                        isPresentingAlert = false
                    }
                }
            }
        }
        .padding()
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                saveTournament()
                dismiss()
            }) {
                Text("Save")
            }
            .disabled(!canSaveTournament())
        }
    }
    
    private func addCompetitor(named competitorName: String, seed: Int? = nil) {
        let competitor = Competitor(id: UUID(), seed: seed ?? 0, name: competitorName)
        competitors.append(competitor)
    }
    
    private func canSaveTournament() -> Bool {
        !tournamentName.isEmpty && competitors.count > 1
    }
    
    private func saveTournament() {
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

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Bracket.self, configurations: config)
    let context = ModelContext(container)
    return NewBracketView()
        .modelContext(context)
}
