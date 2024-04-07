//
//  DashboardView.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 05/04/24.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @State private var path = NavigationPath()
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0.0) {
                MatchesCarousel(matches: viewModel.nextMatches)
                Divider()
                Section {
                    if viewModel.brackets.isEmpty {
                        Text("No tournaments")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        List {
                            ForEach(viewModel.brackets) { bracket in
                                let matches = bracket.matches
                                let descriptions = matches.map(viewModel.title(for:))
                                DashboardBracketRow(title: bracket.title, matchDescriptions: descriptions)
                                    .onTapGesture {
                                        path.append(bracket)
                                    }
                                    .navigationDestination(for: Bracket.self) { bracket in
                                        BracketDetailsView(modelContext: viewModel.modelContext, bracket: bracket)
                                    }
                            }
                            .onDelete(perform: deleteItems(offset:))
                        }
                        
                    }
                } header: {
                    Text("Tournaments")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                        .padding()
                }
                .listStyle(.inset)
                Divider()
                Button("New Tournament") {
                    path.append("create-tournament")
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding()
                .navigationDestination(for: String.self) { _ in
                    NewBracketView(modelContext: viewModel.modelContext)
                }
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
    
    init(modelContext: ModelContext) {
        viewModel = ViewModel(modelContext: modelContext)
    }
    
    func deleteItems(offset: IndexSet) {
        withAnimation {
            viewModel.deleteBrackets(at: offset)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Bracket.self, configurations: config)
    let context = ModelContext(container)
    context.insert(Bracket(id: UUID(), title: "1st Tournament", competitors: [
        Competitor(id: UUID(), name: "Testando"),
        Competitor(id: UUID(), name: "Outro Teste"),
        Competitor(id: UUID(), name: "Mais um teste"),
        Competitor(id: UUID(), name: "Ainda mais um teste"),
    ]))
    context.insert(Bracket(id: UUID(), title: "2nd Tournament", competitors: [
        Competitor(id: UUID(), name: "Testando"),
        Competitor(id: UUID(), name: "Outro Teste"),
        Competitor(id: UUID(), name: "Mais um teste"),
        Competitor(id: UUID(), name: "Ainda mais um teste"),
        Competitor(id: UUID(), name: "Mais um teste"),
        Competitor(id: UUID(), name: "Ainda mais um teste"),
        Competitor(id: UUID(), name: "Mais um teste"),
        Competitor(id: UUID(), name: "Ainda mais um teste"),
    ]))
    context.insert(Bracket(id: UUID(), title: "3rd Tournament", competitors: [
        Competitor(id: UUID(), name: "Testando"),
        Competitor(id: UUID(), name: "Outro Teste"),
    ]))
    return DashboardView(modelContext: context)
}
