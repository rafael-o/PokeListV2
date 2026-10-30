import Foundation
import SwiftData
import Combine
import Networking

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [FavoritePokemon] = []
    private var modelContext: ModelContext!
    
    init() { }
    
    func start(context: ModelContext) {
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
}
