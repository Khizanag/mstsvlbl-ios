//
//  BookmarksViewModel.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation
import SwiftUI

// MARK: - ViewModel
@Observable
final class BookmarksViewModel {
    private(set) var isLoading = false
    private(set) var bookmarkedQuizzes: [Quiz] = []

    @Injected @ObservationIgnored private var getBookmarkedQuizzesUseCase: GetBookmarkedQuizzesUseCase
    @Injected @ObservationIgnored private var userStore: UserStore

    private var user: User?

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
