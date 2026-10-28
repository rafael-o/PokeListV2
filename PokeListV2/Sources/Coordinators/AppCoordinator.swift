import SwiftUI

class AppCoordinator {
    static let shared = AppCoordinator()
    private init() {}
    
    func start(window: UIWindow?) {
        let rootView = PokemonListView()
        window?.rootViewController = UIHostingController(rootView: rootView)
        window?.makeKeyAndVisible()
    }
}
