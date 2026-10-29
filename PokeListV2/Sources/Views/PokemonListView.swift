import SwiftUI
import Networking

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.pokemons, id: \.url) { pokemon in
                NavigationLink(destination: PokemonDetailView(url: pokemon.url)) {
                    PokemonCardView(pokemon: pokemon)
                }
                .onAppear {
                    viewModel.loadMoreIfNeeded(currentItem: pokemon)
                }
            }
            .navigationTitle("Pokémon")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: FavoritesView()) {
                            Image(systemName: "star")
                        }
                    }
                }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if viewModel.pokemons.isEmpty {
                    viewModel.fetchPokemons()
                }
            }
        }
    }
}
