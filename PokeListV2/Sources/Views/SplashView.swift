import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.teal.ignoresSafeArea()
            Text("PokeList")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}
