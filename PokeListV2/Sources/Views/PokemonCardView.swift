import SwiftUI
import Networking
import Networking

struct PokemonCardView: View {
    let pokemon: PokemonListItem
    
    var body: some View {
        HStack(spacing: 12) {
            if let id = pokemon.id, let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png") {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable().scaledToFit()
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 50, height: 50)
            }
            Text(pokemon.name.capitalized)
                .font(.headline)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
