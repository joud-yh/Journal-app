//
//  JournalEditorViewModel.swift
//  Journali
//
//  Created by joud on 30/05/1448 AH.
//

import Foundation
import Observation

@Observable
final class JournalEditorViewModel {

    var title: String
    var body: String

    // nil when creating a new entry; the entry being edited otherwise
    private let originalEntry: JournalEntry?

    init(entry: JournalEntry?) {
        self.originalEntry = entry
        self.title = entry?.title ?? ""
        self.body = entry?.body ?? ""
    }

    var isNewEntry: Bool {
        originalEntry == nil
    }

    // A new entry shows today's date; an edited entry keeps its original date
    var displayDate: Date {
        originalEntry?.createdAt ?? Date()
    }

    // The title is required, so spaces alone don't count
    var canSave: Bool {
        !cleanTitle.isEmpty
    }

    var cleanTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var hasUnsavedChanges: Bool {
        title != (originalEntry?.title ?? "") || body != (originalEntry?.body ?? "")
    }
}
