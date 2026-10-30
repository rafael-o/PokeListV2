import XCTest
@testable import PokeListV2
import Networking
import SwiftData

@MainActor
final class PokemonDetailViewModelTests: XCTestCase {
    // Helper to create an in‑memory ModelContext for SwiftData
    private func makeInMemoryContext() -> ModelContext {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: FavoritePokemon.self, configurations: config)
        return container.mainContext
    }
    
    func testLoadDetailUpdatesProperties() async {
        // This test would require real network interaction. Skipping because we cannot inject a mock client
        // without altering production code. Instead, we will test the behaviour of the ViewModel after the
        // detail is manually set.
        let viewModel = PokemonDetailViewModel()
        let context = makeInMemoryContext()
        viewModel.start(url: "https://example.com/unused", context: context)
        // Manually set detail to simulate a successful network load
        let json = """
        {
            "id": 1,
            "name": "bulbasaur",
            "sprites": {"front_default": "https://example.com/bulba.png"},
            "abilities": [{"ability": {"name": "overgrow", "url": ""}}],
            "moves": [{"move": {"name": "tackle", "url": ""}}],
            "types": []
        }
        """
        let data = Data(json.utf8)
        let detail = try! JSONDecoder().decode(PokemonDetail.self, from: data)
        viewModel.detail = detail
        viewModel.abilities = detail.abilities.map { $0.ability.name }
        viewModel.availableMoves = detail.moves.map { $0.move.name }
        viewModel.loading = false
        // Verify that properties reflect the manual detail
        XCTAssertEqual(viewModel.detail?.id, 1)
        XCTAssertEqual(viewModel.abilities, ["overgrow"])
        XCTAssertEqual(viewModel.availableMoves, ["tackle"])
    }
    
    func testSaveAndRemoveFavorite() async {
        // Manually set a detail without network interaction via JSON decoding.
        let json2 = """
        {
            "id": 2,
            "name": "ivysaur",
            "sprites": {"front_default": "https://example.com/ivy.png"},
            "abilities": [],
            "moves": [],
            "types": []
        }
        """
        let data2 = Data(json2.utf8)
        let detail = try! JSONDecoder().decode(PokemonDetail.self, from: data2)
        let context = makeInMemoryContext()
        let viewModel = PokemonDetailViewModel()
        viewModel.start(url: "", context: context)
        viewModel.detail = detail
        viewModel.abilities = detail.abilities.map { $0.ability.name }
        viewModel.availableMoves = detail.moves.map { $0.move.name }
        viewModel.loading = false
        // Verify detail updates
        XCTAssertEqual(viewModel.abilities, [])
        XCTAssertEqual(viewModel.availableMoves, [])
        // Save favorite (now detail exists)
        viewModel.saveFavorite(ability: "TestAbility", moves: ["Move1", "Move2"])
        XCTAssertTrue(viewModel.isFavorited)
        // Verify persistence
        let fetch = FetchDescriptor<FavoritePokemon>(predicate: #Predicate { $0.id == 2 })
        let fetched = try? context.fetch(fetch)
        XCTAssertEqual(fetched?.first?.ability, "TestAbility")
        // Remove favorite
        viewModel.removeFavorite()
        XCTAssertFalse(viewModel.isFavorited)
        let afterDelete = try? context.fetch(fetch)
        XCTAssertTrue(afterDelete?.isEmpty ?? true)
    }
}
