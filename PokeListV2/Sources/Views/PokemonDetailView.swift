import SwiftUI
import Networking
import SwiftData

struct PokemonDetailView: View {
    let url: String
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = PokemonDetailViewModel()
    @State private var showSelection = false
    @State private var selectedAbility: String?
    @State private var selectedMoves: Set<String> = []
    
    init(url: String) {
        self.url = url
        _viewModel = StateObject(wrappedValue: PokemonDetailViewModel())
    }
    
    var body: some View {
        Group {
            if viewModel.loading {
                ProgressView("Carregando…")
            } else if let detail = viewModel.detail {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Image
                        if let imgURL = URL(string: detail.sprites.front_default ?? "") {
                            AsyncImage(url: imgURL) { phase in
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
                            .frame(width: 150, height: 150)
                            .centerHorizontally()
                        }
                        // Name & ID
                        Text("#\(detail.id) \(detail.name.capitalized)")
                            .font(.title)
                            .bold()
                        // Types
                        if !detail.types.isEmpty {
                            Text("Tipos: \(detail.types.map { $0.type.name.capitalized }.joined(separator: ", ")))")
                        }
                        // Abilities list
                        if !detail.abilities.isEmpty {
                            Text("Habilidades:")
                                .font(.headline).padding(.top, 6)
                            ForEach(detail.abilities, id: \ .ability.name) { ability in
                                Text(ability.ability.name.capitalized)
                            }
                        }
                        // Moves list (first 20)
                        if !detail.moves.isEmpty {
                            Text("Ataques:")
                                .font(.headline).padding(.top, 6)
                            ForEach(detail.moves.prefix(20), id: \ .move.name) { move in
                                Text(move.move.name.capitalized)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if viewModel.isFavorited {
                                viewModel.removeFavorite()
                            } else {
                                showSelection = true
                            }
                        }) {
                            Image(systemName: viewModel.isFavorited ? "star.fill" : "star")
                                .foregroundColor(viewModel.isFavorited ? .yellow : .primary)
                        }
                    }
                }
                .sheet(isPresented: $showSelection) {
                    if let detail = viewModel.detail {
                        FavoriteSelectionView(
                            abilities: viewModel.abilities,
                            moves: viewModel.availableMoves,
                            selectedAbility: $selectedAbility,
                            selectedMoves: $selectedMoves
                        )
                        .onDisappear {
                            if let ability = selectedAbility, !selectedMoves.isEmpty {
                                viewModel.saveFavorite(ability: ability, moves: Array(selectedMoves))
                                selectedAbility = nil
                                selectedMoves.removeAll()
                            }
                        }
                    }
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            viewModel.start(url: url, context: modelContext)
        }
    }
}

extension View {
    func centerHorizontally() -> some View {
        HStack { Spacer(); self; Spacer() }
    }
}
