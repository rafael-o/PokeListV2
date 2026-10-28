import SwiftUI
import Networking

struct PokemonDetailView: View {
    let url: String
    @State private var detail: PokemonDetail?
    @State private var loading = true
    @State private var errorMessage: String?
    
    var body: some View {
        Group {
            if loading {
                ProgressView("Carregando…")
            } else if let detail = detail {
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
                            Text("Tipos: \(detail.types.map { $0.type.name.capitalized }.joined(separator: ", "))")
                        }
                        // Abilities
                        if !detail.abilities.isEmpty {
                            Text("Habilidades:")
                                .font(.headline).padding(.top, 6)
                            ForEach(detail.abilities, id: \.ability.name) { ability in
                                Text(ability.ability.name.capitalized)
                            }
                        }
                        // Moves
                        if !detail.moves.isEmpty {
                            Text("Ataques:")
                                .font(.headline).padding(.top, 6)
                            ForEach(detail.moves.prefix(20), id: \ .move.name) { move in // show first 20
                                Text(move.move.name.capitalized)
                            }
                        }
                    }
                                        .padding(.horizontal, 16)
                }
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            Task {
                await loadDetail()
            }
        }
        .navigationTitle(detail?.name.capitalized ?? "Detalhes")
    }
    
    private func loadDetail() async {
        do {
            let client = PokeAPIClient()
            self.detail = try await client.fetchPokemonDetail(from: url)
            self.loading = false
        } catch {
            self.errorMessage = "Falha ao carregar detalhes: \(error)"
            self.loading = false
        }
    }
}

extension View {
    func centerHorizontally() -> some View {
        HStack { Spacer(); self; Spacer() }
    }
}
