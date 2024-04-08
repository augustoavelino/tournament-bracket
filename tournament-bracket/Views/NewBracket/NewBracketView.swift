//
//  NewBracketView.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import SwiftData
import SwiftUI

struct NewBracketView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(modelContext: ModelContext) {
        viewModel = ViewModel(modelContext: modelContext)
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            VStack(spacing: 0.0) {
                TextField("Tournament", text: $viewModel.tournamentName)
                    .font(.title)
                Divider()
                    .padding(.top, 8.0)
            }
            VStack {
                List {
                    Section {
                        ForEach(viewModel.competitors) { competitor in
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
                    viewModel.alertText = ""
                    viewModel.isPresentingAlert = true
                }
                .alert("New Competitor", isPresented: $viewModel.isPresentingAlert) {
                    TextField("Name", text: $viewModel.alertText)
                    Button("Add") {
                        viewModel.addCompetitor(named: viewModel.alertText)
                        viewModel.isPresentingAlert = false
                    }
                    Button("Cancel", role: .cancel) {
                        viewModel.isPresentingAlert = false
                    }
                }
            }
        }
        .padding()
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                viewModel.saveTournament()
                dismiss()
            }) {
                Text("Save")
            }
            .disabled(!viewModel.canSaveTournament())
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Bracket.self, configurations: config)
    let context = ModelContext(container)
    return NewBracketView(modelContext: context)
}
