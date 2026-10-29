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
    
    init(favorite: FavoritePokemon) {
        self.favorite = favorite
        _viewModel = StateObject(wrappedValue: PokemonFavoriteDetailViewModel())
    }
    
    var body: some View {
        // Copia dos dados para evitar faults após deleção
        let data = FavoriteData(
            id: favorite.id,
            name: favorite.name,
            imageUrl: favorite.imageUrl,
            ability: favorite.ability,
            moves: favorite.moves
        )
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
                ForEach(data.moves, id: \ .self) { move in
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
        .onAppear {
            viewModel.start(pokemonId: self.favorite.id, context: modelContext)
        }
    }
}
