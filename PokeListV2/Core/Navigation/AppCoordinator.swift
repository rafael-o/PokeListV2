//
//  AppCoordinator.swift
//  PokeListV2
//
//  Created by admin on 10/29/26.
//

import SwiftUI

@MainActor
@Observable
final class AppCoordinator: Coordinating {
    
    var path: [Route] = []
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func makePokemonList() -> some View {
        PokemonListView(router: PokemonListRouter(coordinator: self))
    }
    
    @ViewBuilder
    func destination(_ route: Route) -> some View {
        switch route {
        case .detail(let url):
            PokemonDetailView(url: url)
        case .favorites:
            FavoritesView(router: FavoritesRouter(coordinator: self))
        case .favoriteDetail(let favorite):
            PokemonFavoriteDetailView(favorite: favorite)
        }
    }
}
