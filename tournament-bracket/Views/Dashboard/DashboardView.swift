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
                DashboardSection(title: "Up next") {
                    DashboardMatchCarousel(matches: viewModel.nextMatches)
                }
                .frame(height: 240.0)
                .navigationDestination(for: Match.self) { match in
                    MatchDetailsView(match: match)
                }
                Divider()
                DashboardSection(title: "Tournaments", headerTrailing: EmptyView.init) {
                    ZStack {
                        List {
                            ForEach(viewModel.brackets) { bracket in
                                DashboardBracketRow(title: bracket.title)
                                    .onTapGesture {
                                        path.append(bracket)
                                    }
                            }
                            .onDelete(perform: deleteItems(offset:))
                        }
                        .listStyle(.inset)
                        if viewModel.brackets.isEmpty {
                            Text("No tournaments")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                }
                .navigationDestination(for: Bracket.self) { bracket in
                    BracketDetailsView(modelContext: viewModel.modelContext, bracket: bracket)
                }
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
    let addPreviewBrackets = true
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Bracket.self, configurations: config)
    let context = ModelContext(container)
    if addPreviewBrackets {
        context.insert(Bracket(id: UUID(), title: "1st Tournament", competitors: [
            Competitor(id: UUID(), name: "Team 1"),
            Competitor(id: UUID(), name: "Team 2"),
            Competitor(id: UUID(), name: "Team 3"),
            Competitor(id: UUID(), name: "Team 4"),
        ]))
        context.insert(Bracket(id: UUID(), title: "2nd Tournament", competitors: [
            Competitor(id: UUID(), name: "Time 1"),
            Competitor(id: UUID(), name: "Time 2"),
            Competitor(id: UUID(), name: "Time 3"),
            Competitor(id: UUID(), name: "Time 4"),
            Competitor(id: UUID(), name: "Time 5"),
            Competitor(id: UUID(), name: "Time 6"),
            Competitor(id: UUID(), name: "Time 7"),
            Competitor(id: UUID(), name: "Time 8"),
        ]))
        context.insert(Bracket(id: UUID(), title: "3rd Tournament", competitors: [
            Competitor(id: UUID(), name: "Team 1"),
            Competitor(id: UUID(), name: "Team 2"),
        ]))
    }
    return DashboardView(modelContext: context)
}
