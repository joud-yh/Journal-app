
import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            // Background
            Color.backgroundPrimary
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
