//
//  Coordinating.swift
//  PokeListV2
//
//  Created by admin on 10/29/26.
//

@MainActor
protocol Coordinating: AnyObject {
    func push(_ route: Route)
    func pop()
    func popToRoot()
}
