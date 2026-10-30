import Foundation
import Combine
import Networking

final class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [PokemonListItem] = []
    private var offset = 0
    private let limit = 100
    private var isFetching = false
    private var hasMore = true // stop when API signals no next page
    
    func fetchPokemons() {
        guard !isFetching && hasMore else { return }
        isFetching = true
        Task {
            do {
                let client = PokeAPIClient()
                let response = try await client.fetchPokemonList(offset: offset, limit: limit)
                await MainActor.run {
                    self.pokemons.append(contentsOf: response.results)
                    self.offset += self.limit
                    self.isFetching = false
                    self.hasMore = response.next != nil
                }
            } catch {
                await MainActor.run { self.isFetching = false }
                print("Erro ao buscar pokémons: \(error)")
            }
        }
    }
    
    // Triggered when a row appears; loads next page if this is the last item
    func loadMoreIfNeeded(currentItem: PokemonListItem) {
        guard let last = pokemons.last else { return }
        if currentItem.url == last.url {
            fetchPokemons()
        }
    }
}
