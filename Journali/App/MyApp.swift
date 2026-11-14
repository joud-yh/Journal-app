import SwiftUI

@main struct MyApp: App {

    // true while the Splash is on screen; becomes false once to show the Main page
    @State private var isShowingSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if isShowingSplash {
                    SplashView()
                        .transition(.opacity)
                } else {
                    JournalMainView()
                        .transition(.opacity)
                }
            }
            .preferredColorScheme(.dark)
            .task {
                // Keep the Splash visible for 2 seconds, then fade to the Main page
                try? await Task.sleep(for: .seconds(2))
                withAnimation(.easeInOut(duration: 0.4)) {
                    isShowingSplash = false
                }
            }
        }
    }
}
