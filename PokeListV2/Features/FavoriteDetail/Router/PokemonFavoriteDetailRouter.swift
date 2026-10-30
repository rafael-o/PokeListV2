//
//  PokemonFavoriteDetailRouter.swift
//  PokeListV2
//
//  Created by admin on 10/30/26.
//

@MainActor
final class PokemonFavoriteDetailRouter {
    
    private let coordinator: any Coordinating
    
    init(coordinator: any Coordinating) {
        self.coordinator = coordinator
    }
    
    func back() {
        coordinator.pop()
    }
}
