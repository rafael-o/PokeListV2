//
//  PokeListV2App.swift
//  PokeListV2
//
//  Created by Rafael de Oliveira on 10/28/26.
//

import SwiftUI
import SwiftData
import Networking
import UIKit

@main
struct PokeListV2App: App {
    // Configura a barra de navegação: fundo azul‑claro, título e botão voltar brancos
    init() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor.systemTeal // azul‑claro
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        let navAppearanceCompact = navAppearance
        navAppearanceCompact.titleTextAttributes = [.foregroundColor: UIColor.white]
        navAppearanceCompact.largeTitleTextAttributes = [:]
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearanceCompact
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().tintColor = .white // cor do botão "Back"
    }
    
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

