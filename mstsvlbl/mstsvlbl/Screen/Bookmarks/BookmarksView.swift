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
    @State private var allQuizzes: [Quiz] = []
    @State private var isLoading = false
    private let repository: QuizRepository = BundleQuizRepository()
    
    @State private var selectedItemId: String? = nil
    
    var body: some View {
        content
            .navigationTitle("Bookmarks")
            .task { await loadQuizzesIfNeeded() }
    }
}

private extension BookmarksView {
    var bookmarkedQuizzes: [Quiz] {
        allQuizzes.filter { userStore.user.bookmarks.contains($0.id) }
    }
    
    @ViewBuilder
    var content: some View {
        if isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else if bookmarkedQuizzes.isEmpty {
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
            List(bookmarkedQuizzes, id: \.id, selection: $selectedItemId) { quiz in
                HStack {
                    Text(quiz.title)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(DesignBook.Color.textSecondary)
                }
            }
            .onChange(of: selectedItemId) { (oldValue, newValue) in
                guard let newValue, let quiz = allQuizzes.first(where: { $0.id == newValue }) else { return }
                
                coordinator.fullScreenCover(.overview(quiz))
                withAnimation {
                    selectedItemId = nil
                }
            }
        }
    }
    
    func loadQuizzesIfNeeded() async {
        guard allQuizzes.isEmpty, !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            allQuizzes = try await repository.getAll()
        } catch {
            allQuizzes = []
        }
    }
}

#Preview {
    BookmarksView()
}
