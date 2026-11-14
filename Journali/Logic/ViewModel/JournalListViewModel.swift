//
//  JournalListViewModel.swift
//  Journali
//
//  Created by joud on 30/05/1448 AH.
//

import Foundation
import Observation
import SwiftData

@Observable
final class JournalListViewModel {

    // The two options of the filter menu in the design
    enum SortOption {
        case entryDate
        case bookmark
    }

    // The single source of truth: every saved entry, newest first
    private(set) var entries: [JournalEntry] = []

    var searchText = ""
    var sortOption: SortOption = .entryDate

    // SwiftData's connection to the database on the device
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetchEntries()
    }

    // What the list actually shows: the saved entries after the filter and the search
    var displayedEntries: [JournalEntry] {
        var result = entries

        if sortOption == .bookmark {
            result = result.filter { $0.isBookmarked }
        }

        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !query.isEmpty {
            result = result.filter {
                $0.title.localizedStandardContains(query) || $0.body.localizedStandardContains(query)
            }
        }

        return result
    }

    var isSearching: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func addEntry(title: String, body: String) {
        context.insert(JournalEntry(title: title, body: body))
        saveChanges()
    }

    func updateEntry(_ entry: JournalEntry, title: String, body: String) {
        entry.title = title
        entry.body = body
        saveChanges()
    }

    func deleteEntry(_ entry: JournalEntry) {
        context.delete(entry)
        saveChanges()
    }

    func toggleBookmark(for entry: JournalEntry) {
        entry.isBookmarked.toggle()
        saveChanges()
    }

    // Writes the changes to the device, then reloads the array so the screen updates
    private func saveChanges() {
        do {
            try context.save()
        } catch {
            print("Could not save the journal: \(error)")
        }
        fetchEntries()
    }

    private func fetchEntries() {
        let descriptor = FetchDescriptor<JournalEntry>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        entries = (try? context.fetch(descriptor)) ?? []
    }
}
