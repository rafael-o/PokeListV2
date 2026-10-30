import Foundation
import SwiftData
import Combine

@MainActor
final class PokemonFavoriteDetailViewModel: ObservableObject {
    private var modelContext: ModelContext!
    private var pokemonId: Int!
    @Published var removed = false
    
    init() { }
    
    func start(pokemonId: Int, context: ModelContext) {
        self.pokemonId = pokemonId
        self.modelContext = context
    }
    
    func removeFromFavorites() {
        let descriptor = FetchDescriptor<FavoritePokemon>(predicate: #Predicate { $0.id == pokemonId })
        do {
            if let toDelete = try modelContext.fetch(descriptor).first {
                modelContext.delete(toDelete)
                try modelContext.save()
                removed = true
            }
        } catch {
            print("Failed to delete favorite: \(error)")
        }
    }
}
