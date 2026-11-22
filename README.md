# Journali 📓

**Your thoughts, your story.**

Journali is a simple journaling app for iPhone, built with SwiftUI. Write daily entries, bookmark the ones that matter, and find anything again with search and filters. Everything is saved locally on your device.

## Features

- **Create entries**: give each entry a title and write freely. The date is added automatically.
- **Edit entries**: tap any card to open it. Your changes update the same entry, and the original date stays the same.
- **Delete entries**: swipe left on a card, then confirm in the alert.
- **Bookmark**: tap the bookmark icon on a card to save your favorites.
- **Search**: find entries by any word in the title or the text.
- **Filter**: show only bookmarked entries, or sort all entries by date (newest first).
- **Unsaved changes protection**: closing the editor with unsaved changes asks before discarding them.
- **Empty states**: a friendly screen when you have no entries, no bookmarks, or no search results.
- **Local storage**: entries stay saved after closing and reopening the app.

## Built With

- **Swift & SwiftUI**
- **SwiftData**: local storage on the device
- **MVVM architecture**
- **Liquid Glass**: native iOS components (toolbar, sheets, menus, alerts)
- **SF Pro & SF Symbols**

## Project Structure

```
Journali
├── App
│   └── MyApp.swift                 # App entry: Splash → Main page, sets up SwiftData
├── Logic
│   ├── Model
│   │   └── JournalEntry.swift      # The journal entry saved with SwiftData
│   └── ViewModel
│       ├── JournalListViewModel.swift    # Add, edit, delete, bookmark, search, filter
│       └── JournalEditorViewModel.swift  # Editor draft, title validation, unsaved changes
├── Resources
│   └── Assets                      # Colors, illustrations, app icon
└── View
    ├── SplashView.swift
    ├── JournalMainView.swift       # Main page: toolbar, search, list or empty state
    ├── EmptyStateView.swift
    ├── JournalListView.swift
    ├── JournalCardView.swift
    └── JournalEditorView.swift     # New / Edit journal sheet
```

## How It Works

- **Model**: `JournalEntry` has a title, body, creation date, and bookmark status. It is marked with `@Model` so SwiftData saves it.
- **ViewModel**: `JournalListViewModel` is the single source of truth. Every change (add, edit, delete, bookmark) goes through it, gets saved to the device, and the list reloads.
- **View**: screens only display data and send user actions to the ViewModel. The main page switches between the empty state and the list based on the actual saved entries.

## Requirements

- Xcode 27.2 or later
- iOS 27.2 or later
- iPhone (portrait)

## Getting Started

1. Clone the repository:
   ```bash
   https://github.com/joud-yh/Journal-app.git
   ```
2. Open `Journali.xcodeproj` in Xcode.
3. Choose an iPhone simulator running iOS 27.2.
4. Press **Run** (⌘R).
