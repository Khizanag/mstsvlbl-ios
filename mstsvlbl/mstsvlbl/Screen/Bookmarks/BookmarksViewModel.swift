//
//  BookmarksViewModel.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Observation
import SwiftUI

@Observable
final class BookmarksViewModel {
    private(set) var isLoading = false
    private(set) var bookmarkedQuizzes: [Quiz] = []

    private let getBookmarkedQuizzesUseCase: GetBookmarkedQuizzesUseCase

    private var user: User?

    init(getBookmarkedQuizzesUseCase: GetBookmarkedQuizzesUseCase = DefaultGetBookmarkedQuizzesUseCase()) {
        self.getBookmarkedQuizzesUseCase = getBookmarkedQuizzesUseCase
    }

    @MainActor
    func loadQuizzesIfNeeded(user: User) async {
        guard bookmarkedQuizzes.isEmpty else {
            self.user = user
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
    }
}
