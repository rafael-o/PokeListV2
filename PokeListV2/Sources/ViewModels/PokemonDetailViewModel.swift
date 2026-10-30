import Foundation
import SwiftData
import Combine
import Networking

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    private var url: String!
    private var modelContext: ModelContext!
    @Published var detail: PokemonDetail?
    @Published var loading = true
    @Published var errorMessage: String?
    @Published var abilities: [String] = []
    @Published var availableMoves: [String] = []
    
    init() { }
    
    func start(url: String, context: ModelContext) {
        self.url = url
        self.modelContext = context
        Task { await loadDetail(); updateFavoriteStatus() }
    }
    
    @Published var isFavorited: Bool = false
    
    private func updateFavoriteStatus() {
        guard let id = detail?.id else {
            isFavorited = false
            return
        }
        let descriptor = FetchDescriptor<FavoritePokemon>(predicate: #Predicate { $0.id == id })
        do {
            let favorites = try modelContext.fetch(descriptor)
            isFavorited = !favorites.isEmpty
        } catch {
            print("Failed to check favorite status: \(error)")
            isFavorited = false
        }
    }
    
    init(url: String, context: ModelContext) {
        self.url = url
        self.modelContext = context
        Task { await loadDetail(); updateFavoriteStatus() }
    }
    
    private func loadDetail() async {
        do {
            let client = PokeAPIClient()
            self.detail = try await client.fetchPokemonDetail(from: url)
            self.loading = false
            self.abilities = detail?.abilities.map { $0.ability.name } ?? []
            self.availableMoves = detail?.moves.map { $0.move.name } ?? []
        } catch {
            self.errorMessage = "Falha ao carregar detalhes: \(error)"
            self.loading = false
        }
    }
    
    func saveFavorite(ability: String, moves: [String]) {
        guard let detail = detail else { return }
        // Remove existing favorite if any
        removeFavorite()
        
        let fav = FavoritePokemon(
            id: detail.id,
            name: detail.name,
            imageUrl: detail.sprites.front_default.flatMap { URL(string: $0) },
            ability: ability,
            moves: moves
        )
        modelContext.insert(fav)
        do {
            try modelContext.save()
            isFavorited = true
        } catch {
            print("Failed to save favorite: \(error)")
        }
    }
    
    func removeFavorite() {
        guard let id = detail?.id else { return }
        let descriptor = FetchDescriptor<FavoritePokemon>(predicate: #Predicate { $0.id == id })
        do {
            if let toDelete = try modelContext.fetch(descriptor).first {
                modelContext.delete(toDelete)
                saveContext()
                isFavorited = false
            }
        } catch {
            print("Failed to delete favorite: \(error)")
        }
    }
    
    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
