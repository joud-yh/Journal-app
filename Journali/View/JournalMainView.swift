
import SwiftUI
import SwiftData

struct JournalMainView: View {

    // The journal data comes from MyApp; @Bindable lets the search field write into it
    @Bindable var viewModel: JournalListViewModel

    // Which editor sheet is open: New Journal, or Edit Journal for a specific entry
    @State private var isCreatingEntry = false
    @State private var entryBeingEdited: JournalEntry?

    // The entry waiting for the user to confirm "Delete Journal?"
    @State private var entryPendingDeletion: JournalEntry?


    var body: some View {

        NavigationStack {

            ZStack {

                Color.backgroundPrimary
                    .ignoresSafeArea()


                // Empty State or list, decided by the real data, not a separate Bool
                if viewModel.entries.isEmpty {
                    EmptyStateView()
                } else if viewModel.displayedEntries.isEmpty {
                    if viewModel.isSearching {
                        ContentUnavailableView.search(text: viewModel.searchText)
                    } else {
                        ContentUnavailableView(
                            "No Bookmarked Journals",
                            systemImage: "bookmark",
                            description: Text("You don't have any bookmarked journals yet.")
                        )
                    }
                } else {
                    JournalListView(
                        entries: viewModel.displayedEntries,
                        onSelect: { entry in entryBeingEdited = entry },
                        onToggleBookmark: { entry in viewModel.toggleBookmark(for: entry) },
                        onDelete: { entry in entryPendingDeletion = entry }
                    )
                }
            }



            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.large)


            .toolbar {

                ToolbarItemGroup(placement: .topBarTrailing) {


                    Menu {
                        Button("Sort by Bookmark") {
                            viewModel.sortOption = .bookmark
                        }
                        Button("Sort by Entry Date") {
                            viewModel.sortOption = .entryDate
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                    .disabled(viewModel.entries.isEmpty)


                    Button {
                        isCreatingEntry = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }

            .toolbarBackground(.hidden, for: .navigationBar)

            .sheet(isPresented: $isCreatingEntry) {
                JournalEditorView(entry: nil) { title, body in
                    viewModel.addEntry(title: title, body: body)
                }
            }

            .sheet(item: $entryBeingEdited) { entry in
                JournalEditorView(entry: entry) { title, body in
                    viewModel.updateEntry(entry, title: title, body: body)
                }
            }

            .alert(
                "Delete Journal?",
                isPresented: Binding(
                    get: { entryPendingDeletion != nil },
                    set: { isShowing in if !isShowing { entryPendingDeletion = nil } }
                ),
                presenting: entryPendingDeletion
            ) { entry in
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    viewModel.deleteEntry(entry)
                }
            } message: { _ in
                Text("Are you sure you want to delete this journal?")
            }



            .safeAreaInset(edge: .bottom) {

                HStack(spacing: 12) {

                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 24))
                        .foregroundStyle(.secondary)

                    TextField("Search", text: $viewModel.searchText)
                        .disabled(viewModel.entries.isEmpty)

                    Spacer()

                    Button {


                    } label: {
                        Image(systemName: "mic")
                            .font(.system(size: 24))
                            .foregroundStyle(.secondary)
                    }
                    .disabled(true)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .glassEffect(.regular, in: Capsule())
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
            }
        }
        .tint(.textPrimary)
    }
}



#Preview {
    // A temporary in-memory database, so the preview never touches real saved entries
    let container = try! ModelContainer(
        for: JournalEntry.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    JournalMainView(viewModel: JournalListViewModel(context: container.mainContext))
}
