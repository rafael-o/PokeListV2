import Foundation
import SwiftData
import Combine
import Networking

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [FavoritePokemon] = []
    private var modelContext: ModelContext
    
    init(context: ModelContext) {
        self.modelContext = context
        loadFavorites()
    }
    
    func loadFavorites() {
        let descriptor = FetchDescriptor<FavoritePokemon>(sortBy: [SortDescriptor(\.name)])
        do {
            favorites = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to fetch favorites: \(error)")
            favorites = []
        }
    }
    
    func addFavorite(_ pokemon: PokemonDetail, selectedAbility: String, selectedMoves: [String]) {
        let fav = FavoritePokemon(id: pokemon.id,
                                  name: pokemon.name,
                                  imageUrl: pokemon.sprites.front_default.flatMap { URL(string: $0) },
                                  ability: selectedAbility,
                                  moves: selectedMoves)
        modelContext.insert(fav)
        save()
        loadFavorites()
    }
    
    func removeFavorite(by id: Int) {
        let descriptor = FetchDescriptor<FavoritePokemon>(predicate: #Predicate { $0.id == id })
        do {
            if let toDelete = try modelContext.fetch(descriptor).first {
                modelContext.delete(toDelete)
                save()
                loadFavorites()
            }
        } catch {
            print("Failed to delete favorite: \(error)")
        }
    }
    
    func isFavorited(id: Int) -> Bool {
        favorites.contains(where: { $0.id == id })
    }
    
    private func save() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
