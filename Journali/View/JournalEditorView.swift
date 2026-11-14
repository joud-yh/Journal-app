//
//  JournalEditorView.swift
//  Journali
//
//  Created by joud on 30/05/1448 AH.
//

import SwiftUI

struct JournalEditorView: View {

    @State private var viewModel: JournalEditorViewModel
    @State private var isShowingDiscardDialog = false
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) private var dismiss

    // Hands back the finished title and body; the caller decides whether to add or update
    let onSave: (_ title: String, _ body: String) -> Void

    private enum Field {
        case title
        case body
    }

    // entry is nil for "New Journal", or the entry to edit for "Edit Journal"
    init(entry: JournalEntry?, onSave: @escaping (_ title: String, _ body: String) -> Void) {
        _viewModel = State(initialValue: JournalEditorViewModel(entry: entry))
        self.onSave = onSave
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {

                TextField("Title", text: $viewModel.title, axis: .vertical)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.textPrimary)
                    .focused($focusedField, equals: .title)

                Text(viewModel.displayDate.journalDisplayString)
                    .font(.system(size: 14))
                    .foregroundStyle(.textSecondary)
                    .padding(.top, 8)

                TextField("Type your Journal...", text: $viewModel.body, axis: .vertical)
                    .font(.system(size: 18))
                    .foregroundStyle(.textPrimary)
                    .focused($focusedField, equals: .body)
                    .padding(.top, 24)

                // Tapping the empty space under the text moves the cursor into the body
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture { focusedField = .body }
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)
            .background(Color.surfaceCard)
            .tint(.primaryAccent)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        cancel()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .confirmationDialog(
                        "Discard changes?",
                        isPresented: $isShowingDiscardDialog,
                        titleVisibility: .hidden
                    ) {
                        Button("Discard Changes", role: .destructive) {
                            dismiss()
                        }
                        // No .cancel role: iOS hides cancel buttons in popovers, but the design shows this one
                        Button("Keep Editing") {}
                    } message: {
                        Text("Are you sure you want to discard changes on this journal?")
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        save()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.primaryAccent)
                    .disabled(!viewModel.canSave)
                }
            }
        }
        .presentationDragIndicator(.visible)
        .presentationBackground(Color.surfaceCard)
        // Swiping the sheet down is blocked while there are unsaved changes
        .interactiveDismissDisabled(viewModel.hasUnsavedChanges)
        .onAppear {
            focusedField = viewModel.isNewEntry ? .title : .body
        }
    }

    private func cancel() {
        if viewModel.hasUnsavedChanges {
            isShowingDiscardDialog = true
        } else {
            dismiss()
        }
    }

    private func save() {
        onSave(viewModel.cleanTitle, viewModel.body)
        dismiss()
    }
}

#Preview {
    JournalEditorView(entry: nil) { _, _ in }
}
