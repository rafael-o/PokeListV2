import Foundation

public final class PokeAPIClient {
    private let apiClient = APIClient()
    private let baseURL = "https://pokeapi.co/api/v2"
    
    public init() {}
    
    // Fetch list of pokémons with pagination (limit 100)
    public func fetchPokemonList(offset: Int = 0, limit: Int = 100) async throws -> PokemonListResponse {
        let url = "\(baseURL)/pokemon?offset=\(offset)&limit=\(limit)"
        return try await apiClient.request(urlString: url, responseType: PokemonListResponse.self)
    }
    
    // Fetch detailed data for a single pokemon given its URL
    public func fetchPokemonDetail(from urlString: String) async throws -> PokemonDetail {
        return try await apiClient.request(urlString: urlString, responseType: PokemonDetail.self)
    }
}

// MARK: - Decodable structs matching the API
public struct PokemonListResponse: Decodable {
    public let count: Int
    public let next: String?
    public let previous: String?
    public let results: [PokemonListItem]
}

public struct PokemonListItem: Decodable {
    public let name: String
    public let url: String
    
    // Extract numeric ID from URL (last path component)
    public var id: Int? {
        guard let last = URL(string: url)?.lastPathComponent,
              let id = Int(last) else { return nil }
        return id
    }
}

public struct PokemonDetail: Decodable {
    public struct Sprites: Decodable {
        public let front_default: String?
    }
    public struct NamedAPIResource: Decodable {
        public let name: String
        public let url: String
    }
    public struct AbilityInfo: Decodable {
        public let ability: NamedAPIResource
    }
    public struct MoveInfo: Decodable {
        public let move: NamedAPIResource
    }
    public struct TypeInfo: Decodable {
        public let type: NamedAPIResource
    }
    
    public let id: Int
    public let name: String
    public let sprites: Sprites
    public let abilities: [AbilityInfo]
    public let moves: [MoveInfo]
    public let types: [TypeInfo]
}
