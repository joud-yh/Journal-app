//
//  JournalListView.swift
//  Journali
//
//  Created by joud on 30/05/1448 AH.
//

import SwiftUI

struct JournalListView: View {

    let entries: [JournalEntry]
    let onSelect: (JournalEntry) -> Void
    let onToggleBookmark: (JournalEntry) -> Void
    let onDelete: (JournalEntry) -> Void

    var body: some View {
        List {
            ForEach(entries) { entry in
                JournalCardView(entry: entry) {
                    onToggleBookmark(entry)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    onSelect(entry)
                }
                // Swipe left to reveal the red trash button; the alert asks before deleting
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        onDelete(entry)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.destructive)
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 22, bottom: 8, trailing: 22))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollDismissesKeyboard(.immediately)
    }
}

#Preview {
    JournalListView(
        entries: [
            JournalEntry(title: "My Birthday", body: "Lorem ipsum dolor sit amet."),
            JournalEntry(title: "Great Day", body: "Lorem ipsum dolor sit amet.")
        ],
        onSelect: { _ in },
        onToggleBookmark: { _ in },
        onDelete: { _ in }
    )
    .background(Color.backgroundPrimary)
}
