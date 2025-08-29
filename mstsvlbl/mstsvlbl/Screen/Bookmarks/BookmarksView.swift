//
//  BookmarksView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct BookmarksView: View {
    @Environment(UserStore.self) private var userStore
    @State private var allQuizzes: [Quiz] = []

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Bookmarks")
        }
    }
}

private extension BookmarksView {
    var bookmarkedQuizzes: [Quiz] {
        allQuizzes.filter { userStore.user.bookmarks.contains($0.id) }
    }

    @ViewBuilder
    var content: some View {
        if bookmarkedQuizzes.isEmpty {
            VStack(spacing: DesignBook.Spacing.lg) {
                Image(systemName: "bookmark")
                    .font(.system(size: 48))
                    .foregroundStyle(DesignBook.Color.textSecondary)
                Text("No bookmarks yet")
                    .font(DesignBook.Font.headline)
                Text("Save your favorite quizzes to find them quickly.")
                    .font(DesignBook.Font.subheadline)
                    .foregroundStyle(DesignBook.Color.textSecondary)
                Spacer()
            }
            .padding(DesignBook.Layout.contentPadding)
        } else {
            List(bookmarkedQuizzes, id: \.id) { quiz in
                Text(quiz.title)
            }
        }
    }
}

#Preview {
    BookmarksView()
}


