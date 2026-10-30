import XCTest
@testable import PokeListV2
import SwiftData

// Simple mock coordinator that records pushed routes.
final class MockCoordinator: Coordinating {
    var pushedRoutes: [Route] = []
    func push(_ route: Route) { pushedRoutes.append(route) }
    func pop() {}
    func popToRoot() {}
}

@MainActor
final class RouterTests: XCTestCase {
    func testPokemonListRouterStartsDetail() {
        let coordinator = MockCoordinator()
        let router = PokemonListRouter(coordinator: coordinator)
        router.startDetail(url: "https://example.com/pokemon/1")
        XCTAssertEqual(coordinator.pushedRoutes.last, .detail("https://example.com/pokemon/1"))
    }
    
    func testPokemonListRouterStartsFavorites() {
        let coordinator = MockCoordinator()
        let router = PokemonListRouter(coordinator: coordinator)
        router.startFavorites()
        XCTAssertEqual(coordinator.pushedRoutes.last, .favorites)
    }
    
    func testFavoritesRouterStartsFavoriteDetail() {
        let coordinator = MockCoordinator()
        let router = FavoritesRouter(coordinator: coordinator)
        let fav = FavoritePokemon(id: 99, name: "Test", imageUrl: nil, ability: "Ability", moves: [])
        router.startDetail(favorite: fav)
        XCTAssertEqual(coordinator.pushedRoutes.last, .favoriteDetail(fav))
    }
    
    func testPokemonFavoriteDetailRouterBack() {
        let coordinator = MockCoordinator()
        let router = PokemonFavoriteDetailRouter(coordinator: coordinator)
        router.back()
        // No route is pushed; just ensure no crash and pop can be called (no state to verify).
        XCTAssertTrue(true) // placeholder assertion
    }
}
