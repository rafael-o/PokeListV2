import SwiftUI
import Networking

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    
    let router: PokemonListRouter
    
    init(router: PokemonListRouter) {
        self.router = router
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.pokemons, id: \.url) { pokemon in
                PokemonCardView(pokemon: pokemon)
                .onAppear {
                    viewModel.loadMoreIfNeeded(currentItem: pokemon)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    router.startDetail(url: pokemon.url)
                }
            }
            .navigationTitle("Pokémon")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "star")
                            .onTapGesture {
                                router.startFavorites()
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
