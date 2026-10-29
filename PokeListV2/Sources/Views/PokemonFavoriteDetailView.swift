import SwiftUI
import SwiftData

// Estrutura simples para armazenar os dados do favorito antes da remoção
struct FavoriteData {
    let id: Int
    let name: String
    let imageUrl: URL?
    let ability: String
    let moves: [String]
}

struct PokemonFavoriteDetailView: View {
    let favorite: FavoritePokemon
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: PokemonFavoriteDetailViewModel
    @State private var showAlert = false
    @State private var data: FavoriteData? = nil
    
    init(favorite: FavoritePokemon) {
        self.favorite = favorite
        _viewModel = StateObject(wrappedValue: PokemonFavoriteDetailViewModel())
    }
    
    var body: some View {
        // Load data once to avoid accessing faulted properties after deletion
        if let data = data {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let url = data.imageUrl {
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
                    Text("#\(data.id) \(data.name.capitalized)")
                        .font(.title)
                        .bold()
                    Text("Habilidade: \(data.ability.capitalized)")
                        .font(.headline)
                    Text("Ataques:")
                        .font(.headline)
                    ForEach(data.moves, id: \.self) { move in
                        Text(move.capitalized)
                    }
                }
                .padding()
            }
            .navigationTitle(data.name.capitalized)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAlert = true }) {
                        Image(systemName: "trash")
                    }
                    .foregroundColor(.red)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Remover favorito"),
                    message: Text("Deseja remover \(data.name.capitalized) dos favoritos?"),
                    primaryButton: .destructive(Text("Confirmar")) {
                        viewModel.removeFromFavorites()
                    },
                    secondaryButton: .cancel()
                )
            }
            .onChange(of: viewModel.removed) { removed in
                if removed {
                    dismiss()
                }
            }
        } else {
            // Show a placeholder while data is being prepared
            ProgressView()
                .onAppear {
                    // Capture favorite data before any deletion can cause faults
                    data = FavoriteData(
                        id: favorite.id,
                        name: favorite.name,
                        imageUrl: favorite.imageUrl,
                        ability: favorite.ability,
                        moves: favorite.moves
                    )
                    viewModel.start(pokemonId: favorite.id, context: modelContext)
                }
        }
    }
}
