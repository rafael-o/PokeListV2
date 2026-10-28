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
            }
            .navigationTitle("Pokémon")
            .onAppear {
                viewModel.fetchPokemons()
            }
        }
    }
}
