//
//  BookmarksView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
import Foundation

struct BookmarksView: View {
    @Environment(Coordinator.self) private var coordinator
    @State private var viewModel = BookmarksViewModel()
    @State private var selectedItemId: String?
    @Injected private var userStore: UserStore

    var body: some View {
        content
            .navigationTitle("Bookmarks")
            .task { [self] in await viewModel.loadQuizzesIfNeeded(user: userStore.user) }
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
                DesignBook.HeaderView(
                    icon: "bookmark.circle",
                    title: "No bookmarks yet",
                    subtitle: "Save your favorite quizzes to find them quickly"
                )
                
                Spacer()
            }
            .padding(DesignBook.Spacing.xl)
        } else {
            List(viewModel.bookmarkedQuizzes, id: \.id, selection: $selectedItemId) { quiz in
                HStack {
                    Text(quiz.title)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(DesignBook.Color.Text.secondary)
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) { [self] in
                        withAnimation {
                            userStore.toggleBookmark(quizId: quiz.id)
                        }
                    } label: {
                        Label("Remove", systemImage: "bookmark.slash")
                    }
                }
                .contextMenu {
                    Button { [self] in
                        withAnimation {
                            userStore.toggleBookmark(quizId: quiz.id)
                        }
                    } label: {
                        Label("Remove Bookmark", systemImage: "bookmark.slash")
                    }
                }
            }
            .onChange(of: selectedItemId) { [self] (oldValue, newValue) in
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
