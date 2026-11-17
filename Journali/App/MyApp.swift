import SwiftUI
import SwiftData

@main struct MyApp: App {

    // true while the Splash is on screen; becomes false once to show the Main page
    @State private var isShowingSplash = true

    // The database file on the device where journal entries are saved
    private let container: ModelContainer

    // Created once for the whole app, so every screen shares the same journal data
    @State private var journalViewModel: JournalListViewModel

    init() {
        do {
            container = try ModelContainer(for: JournalEntry.self)
        } catch {
            fatalError("Could not open the journal storage: \(error)")
        }
        _journalViewModel = State(initialValue: JournalListViewModel(context: container.mainContext))
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                if isShowingSplash {
                    SplashView()
                        .transition(.opacity)
                } else {
                    JournalMainView(viewModel: journalViewModel)
                        .transition(.opacity)
                }
            }
            .task {
                // Keep the Splash visible for 2 seconds, then fade to the Main page
                try? await Task.sleep(for: .seconds(2))
                withAnimation(.easeInOut(duration: 0.4)) {
                    isShowingSplash = false
                }
            }
            .preferredColorScheme(.dark)
        }
        
    }
}
