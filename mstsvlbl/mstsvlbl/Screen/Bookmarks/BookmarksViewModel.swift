//
//  BookmarksViewModel.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

final class BookmarksViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var bookmarkedQuizzes: [Quiz] = []

    private let getBookmarkedQuizzesUseCase: GetBookmarkedQuizzesUseCase

    private var user: User?

    init(getBookmarkedQuizzesUseCase: GetBookmarkedQuizzesUseCase = DefaultGetBookmarkedQuizzesUseCase()) {
        self.getBookmarkedQuizzesUseCase = getBookmarkedQuizzesUseCase
    }

    @MainActor
    func loadQuizzesIfNeeded(user: User) async {
        guard bookmarkedQuizzes.isEmpty else {
            self.user = user
            objectWillChange.send()
            return
        }
        isLoading = true
        self.user = user
        
        do {
            bookmarkedQuizzes = try await getBookmarkedQuizzesUseCase.execute(for: user)
        } catch {
            print("Error loading bookmarked quizzes: \(error)")
        }
        
        isLoading = false
        objectWillChange.send()
    }
}
