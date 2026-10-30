//
//  Route.swift
//  PokeListV2
//
//  Created by admin on 10/29/26.
//

enum Route: Hashable {
    case detail(String)
    case favorites
    case favoriteDetail(FavoritePokemon)
}
