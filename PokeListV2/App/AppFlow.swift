//
//  AppFlow.swift
//  PokeListV2
//
//  Created by admin on 10/29/26.
//

import SwiftUI

struct AppFlow: View {
    
    @State private var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.makePokemonList()
                .navigationDestination(for: Route.self) { route in
                    coordinator.destination(route)
                }
        }
    }
}
