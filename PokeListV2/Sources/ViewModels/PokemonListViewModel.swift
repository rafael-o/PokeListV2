import Foundation
import Combine
import Networking

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [PokemonListItem] = []
    private var cancellables = Set<AnyCancellable>()
    private var offset = 0
    private let limit = 100
    
    func fetchPokemons() {
        Task {
            do {
                let client = PokeAPIClient()
                let response = try await client.fetchPokemonList(offset: offset, limit: limit)
                await MainActor.run {
                    self.pokemons.append(contentsOf: response.results)
                    self.offset += self.limit
                }
            } catch {
                print("Erro ao buscar pokémons: \(error)")
            }
        }
    }
}
