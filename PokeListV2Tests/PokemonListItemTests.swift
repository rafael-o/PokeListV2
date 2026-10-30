import XCTest
@testable import PokeListV2
import Networking

@MainActor
final class PokemonListItemTests: XCTestCase {
    let sampleJSON = """
    {
        \"name\": \"bulbasaur\",
        \"url\": \"https://pokeapi.co/api/v2/pokemon/1/\"
    }
    """
    
    func testDecoding() async {
        let data = Data(sampleJSON.utf8)
        // No need for a mock client; we decode directly.
        // No need for a mock client; we decode directly.
        do {
            let item = try JSONDecoder().decode(PokemonListItem.self, from: data)
            XCTAssertEqual(item.name, "bulbasaur")
            XCTAssertEqual(item.url, "https://pokeapi.co/api/v2/pokemon/1/")
            XCTAssertEqual(item.id, 1)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}
