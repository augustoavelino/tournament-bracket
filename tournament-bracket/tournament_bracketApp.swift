//
//  tournament_bracketApp.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 05/04/24.
//

import SwiftUI
import SwiftData

@main
struct tournament_bracketApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Bracket.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            DashboardView()
                .modelContext(sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
