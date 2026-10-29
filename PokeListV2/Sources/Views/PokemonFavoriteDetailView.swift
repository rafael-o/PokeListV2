import SwiftUI
import SwiftData

struct PokemonFavoriteDetailView: View {
    let favorite: FavoritePokemon
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let url = favorite.imageUrl {
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
                    .frame(height: 200)
                }
                Text("#\(favorite.id) \(favorite.name.capitalized)")
                    .font(.title)
                    .bold()
                Text("Habilidade: \(favorite.ability.capitalized)")
                    .font(.headline)
                Text("Ataques:")
                    .font(.headline)
                ForEach(favorite.moves, id: \ .self) { move in
                    Text(move.capitalized)
                }
            }
            .padding()
        }
        .navigationTitle(favorite.name.capitalized)
    }
}
