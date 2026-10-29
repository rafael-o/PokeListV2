import XCTest
@testable import PokeListV2

@MainActor
final class PokemonModelTests: XCTestCase {
    func testPokemonInitialization() async {
        let pokemon = Pokemon(id: 1, name: "Bulbasaur", imageUrl: nil)
        await MainActor.run {
            XCTAssertEqual(pokemon.id, 1)
            XCTAssertEqual(pokemon.name, "Bulbasaur")
            XCTAssertNil(pokemon.imageUrl)
        }
    }
}
