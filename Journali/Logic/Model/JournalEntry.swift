//
//  JournalEntry.swift
//  Journali
//
//  Created by joud on 30/05/1448 AH.
//

import Foundation
import SwiftData

// @Model tells SwiftData to save every JournalEntry on the device
@Model
final class JournalEntry {
    @Attribute(.unique) private(set) var id: UUID
    var title: String
    var body: String
    private(set) var createdAt: Date
    var isBookmarked: Bool

    init(title: String, body: String) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.createdAt = Date()
        self.isBookmarked = false
    }
}

extension Date {
    // The design shows dates as day/month/year, e.g. 02/09/2024, always in the Gregorian calendar
    var journalDisplayString: String {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        return formatted(
            .verbatim(
                "\(day: .twoDigits)/\(month: .twoDigits)/\(year: .defaultDigits)",
                timeZone: .current,
                calendar: calendar
            )
        )
    }
}
