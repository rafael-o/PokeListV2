//
//  PokeListV2App.swift
//  PokeListV2
//
//  Created by admin on 10/28/26.
//

import SwiftUI
import SwiftData
import Networking

@main
struct PokeListV2App: App {
    @State private var showSplash = true
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSplash = false
                        }
                    }
            } else {
                PokemonListView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
