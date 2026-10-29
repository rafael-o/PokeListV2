import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query private var favorites: [FavoritePokemon]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Group {
            if favorites.isEmpty {
                Text("Ainda não há Pokémon favoritados.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(favorites, id: \ .id) { fav in
                            NavigationLink(destination: PokemonFavoriteDetailView(favorite: fav)) {
                                FavoriteCardView(favorite: fav)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Favoritos")
    }
}

struct FavoriteCardView: View {
    let favorite: FavoritePokemon
    var body: some View {
        VStack {
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
                .frame(height: 100)
            } else {
                Image(systemName: "photo")
                    .frame(height: 100)
            }
            Text(favorite.name.capitalized)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
    }
}
