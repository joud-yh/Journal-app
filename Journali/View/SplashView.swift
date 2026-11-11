
import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            // Background
            Color.black
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
                    .foregroundStyle(.white)

                // Tagline
                Text("Your thoughts, your story")
                    .font(.system(size: 23, weight: .regular))
                    .foregroundStyle(Color(red: 0.64, green: 0.60, blue: 0.60))

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    SplashView()
}
