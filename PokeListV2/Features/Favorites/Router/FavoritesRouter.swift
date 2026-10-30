//
//  FavoritesRouter.swift
//  PokeListV2
//
//  Created by admin on 10/29/26.
//

@MainActor
final class FavoritesRouter {
    
    private let coordinator: any Coordinating
    
    init(coordinator: any Coordinating) {
        self.coordinator = coordinator
    }
    
    func startDetail(favorite: FavoritePokemon) {
        coordinator.push(.favoriteDetail(favorite))
    }
}
