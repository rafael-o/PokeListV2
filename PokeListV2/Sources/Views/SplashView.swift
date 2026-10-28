import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            Text("PokeList")
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
    }
}
