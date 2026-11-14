
import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            // Background: the gradient from the Splash design in Sketch (top to bottom)
            LinearGradient(
                stops: [
                    .init(color: .splashGradientTop, location: 0),
                    .init(color: .splashGradientMiddle, location: 0.55),
                    .init(color: .splashGradientBottom, location: 1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Content
            VStack(spacing: 18) {

                Spacer()

                //  notebook icon
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                // App Name
                Text("Journali")
                    .font(.system(size: 64, weight: .bold))
                    .foregroundStyle(.textPrimary)

                // Tagline
                Text("Your thoughts, your story")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(.textSecondary)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    SplashView()
}
