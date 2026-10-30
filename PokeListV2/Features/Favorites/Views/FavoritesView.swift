import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: FavoritesViewModel
    
    let router: FavoritesRouter
    
    init(router: FavoritesRouter) {
        _viewModel = StateObject(wrappedValue: FavoritesViewModel())
        self.router = router
    }
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Group {
            if viewModel.favorites.isEmpty {
                Text("Ainda não há Pokémon favoritados.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.favorites, id: \ .id) { fav in
                            FavoriteCardView(favorite: fav)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    router.startDetail(favorite: fav)
                                }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.start(context: modelContext)
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
