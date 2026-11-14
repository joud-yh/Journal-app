//
//  JournalCardView.swift
//  Journali
//
//  Created by joud on 30/05/1448 AH.
//

import SwiftUI

struct JournalCardView: View {

    let entry: JournalEntry
    let onToggleBookmark: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            HStack(alignment: .top) {
                Text(entry.title)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.textAccent)

                Spacer()

                Button(action: onToggleBookmark) {
                    Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 24))
                        .foregroundStyle(.textAccent)
                }
                .buttonStyle(.borderless)
            }

            Text(entry.createdAt.journalDisplayString)
                .font(.system(size: 14))
                .foregroundStyle(.textSecondary)
                .padding(.top, 4)

            Text(entry.body)
                .font(.system(size: 18))
                .foregroundStyle(.textPrimary)
                .lineLimit(5)
                .padding(.top, 23)
        }
        .padding(.horizontal, 26)
        .padding(.vertical, 25)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            // The shadow sits on the card shape only, so the text itself gets no shadow
            RoundedRectangle(cornerRadius: 30)
                .fill(.surfaceCard)
                .shadow(color: Color(red: 143 / 255, green: 143 / 255, blue: 143 / 255).opacity(0.09), radius: 30, y: 2)
        }
    }
}

#Preview {
    JournalCardView(
        entry: JournalEntry(title: "My Birthday", body: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."),
        onToggleBookmark: {}
    )
    .padding()
    .background(Color.backgroundPrimary)
}
