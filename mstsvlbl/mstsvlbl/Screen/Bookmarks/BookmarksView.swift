//
//  BookmarksView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct BookmarksView: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(UserStore.self) private var userStore
    @StateObject private var viewModel = BookmarksViewModel()
    @State private var selectedItemId: String?

    var body: some View {
        content
            .navigationTitle("Bookmarks")
            .task { await viewModel.loadQuizzesIfNeeded(user: userStore.user) }
    }
}

private extension BookmarksView {
    @ViewBuilder
    var content: some View {
        if viewModel.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else if viewModel.bookmarkedQuizzes.isEmpty {
            VStack(spacing: DesignBook.Spacing.lg) {
                Image(systemName: "bookmark")
                    .font(DesignBook.Font.title())
                    .foregroundStyle(DesignBook.Color.Text.secondary)
                Text("No bookmarks yet")
                    .font(DesignBook.Font.headline())
                Text("Save your favorite quizzes to find them quickly.")
                    .font(DesignBook.Font.subheadline())
                    .foregroundStyle(DesignBook.Color.Text.secondary)
                Spacer()
            }
            .padding(DesignBook.Spacing.lg)
        } else {
            List(viewModel.bookmarkedQuizzes, id: \.id, selection: $selectedItemId) { quiz in
                HStack {
                    Text(quiz.title)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(DesignBook.Color.Text.secondary)
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        withAnimation {
                            userStore.toggleBookmark(quizId: quiz.id)
                        }
                    } label: {
                        Label("Remove", systemImage: "bookmark.slash")
                    }
                }
                .contextMenu {
                    Button {
                        withAnimation {
                            userStore.toggleBookmark(quizId: quiz.id)
                        }
                    } label: {
                        Label("Remove Bookmark", systemImage: "bookmark.slash")
                    }
                }
            }
            .onChange(of: selectedItemId) { (oldValue, newValue) in
                guard let newValue, let quiz = viewModel.bookmarkedQuizzes.first(where: { $0.id == newValue }) else { return }
                
                coordinator.fullScreenCover(.overview(quiz))
                withAnimation {
                    selectedItemId = nil
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    BookmarksView()
}
