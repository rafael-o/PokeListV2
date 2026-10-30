import Foundation
import SwiftData

@Model
final class FavoritePokemon {
    @Attribute(.unique) var id: Int // Pokemon ID
    var name: String
    var imageUrl: URL?
    var ability: String // selected ability name
    var moves: [String] // selected move names (max 4)
    
    init(id: Int, name: String, imageUrl: URL?, ability: String, moves: [String]) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.ability = ability
        self.moves = moves
    }
}
