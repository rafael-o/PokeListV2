//
//  PokemonListRouter.swift
//  PokeListV2
//
//  Created by admin on 10/29/26.
//

@MainActor
final class PokemonListRouter {
    
    private let coordinator: any Coordinating
    
    init(coordinator: any Coordinating) {
        self.coordinator = coordinator
    }
    
    func startDetail(url: String) {
        coordinator.push(.detail(url))
    }
    
    func startFavorites() {
        coordinator.push(.favorites)
    }
}
