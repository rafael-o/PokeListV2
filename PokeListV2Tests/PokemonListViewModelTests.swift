import XCTest
import Combine
@testable import PokeListV2
import Networking

@MainActor
final class PokemonListViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func testInitialFetchPopulatesPokemons() async {
        let viewModel = PokemonListViewModel()
        let didChange = expectation(description: "pokemons updated")
        
        viewModel.$pokemons
            .dropFirst() // ignore initial empty value
            .sink { pokemons in
                if !pokemons.isEmpty {
                    didChange.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchPokemons()
        await fulfillment(of: [didChange], timeout: 10.0)
        
        XCTAssertFalse(viewModel.pokemons.isEmpty, "Pokémons should have been fetched")
    }
    
    func testLoadMoreIfNeededTriggersAdditionalFetch() async {
        let viewModel = PokemonListViewModel()
        // First fetch
        let firstFetch = expectation(description: "first fetch")
        viewModel.$pokemons
            .dropFirst()
            .sink { pokemons in
                if !pokemons.isEmpty { firstFetch.fulfill() }
            }
            .store(in: &cancellables)
        viewModel.fetchPokemons()
        await fulfillment(of: [firstFetch], timeout: 10.0)
        
        // Capture count after first fetch
        let initialCount = viewModel.pokemons.count
        guard let lastItem = viewModel.pokemons.last else {
            XCTFail("No items after first fetch")
            return
        }
        // Expect second fetch to add more items
        let secondFetch = expectation(description: "second fetch")
        viewModel.$pokemons
            .dropFirst()
            .sink { _ in secondFetch.fulfill() }
            .store(in: &cancellables)
        
        viewModel.loadMoreIfNeeded(currentItem: lastItem)
        await fulfillment(of: [secondFetch], timeout: 10.0)
        XCTAssertGreaterThan(viewModel.pokemons.count, initialCount, "Pokémons count should increase after loading more")
    }
}
