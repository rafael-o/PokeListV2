import XCTest
@testable import PokeListV2

final class PokemonModelTests: XCTestCase {
    func testPokemonInitialization() {
        let pokemon = Pokemon(id: 1, name: "Bulbasaur", imageUrl: nil)
        XCTAssertEqual(pokemon.id, 1)
        XCTAssertEqual(pokemon.name, "Bulbasaur")
        XCTAssertNil(pokemon.imageUrl)
    }
}
