
import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image("Image 1")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)

            Text("Begin Your Journal")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.textAccent)

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(.textPrimary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView()
        .background(Color.backgroundPrimary)
}
