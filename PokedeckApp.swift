//
//  PokedeckApp.swift
//  Pokedeck
//
//  Created by Franziska Link on 07.11.23.
//

import SwiftUI
import SwiftData

@main
struct PokedeckApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FavoritePokemon.self,
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
            ContentView(api: PokeApi())
        }
        .modelContainer(sharedModelContainer)
    }
}
