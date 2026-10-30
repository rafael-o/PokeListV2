import XCTest
@testable import PokeListV2

@MainActor
final class FavoritePokemonModelTests: XCTestCase {
    func testInitialization() async {
        let fav = FavoritePokemon(id: 25, name: "Pikachu", imageUrl: URL(string: "https://example.com/pikachu.png"), ability: "Static", moves: ["Quick Attack", "Thunderbolt"])
        await MainActor.run {
            XCTAssertEqual(fav.id, 25)
            XCTAssertEqual(fav.name, "Pikachu")
            XCTAssertEqual(fav.imageUrl?.absoluteString, "https://example.com/pikachu.png")
            XCTAssertEqual(fav.ability, "Static")
            XCTAssertEqual(fav.moves, ["Quick Attack", "Thunderbolt"])
        }
    }
}
