//
//  GetBookmarkedQuizzesUseCase.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

// MARK: - Protocol
protocol GetBookmarkedQuizzesUseCase {
    func execute(for user: User) async throws -> [Quiz]
}

// MARK: - Default Implementation
final class DefaultGetBookmarkedQuizzesUseCase: GetBookmarkedQuizzesUseCase {
    private let repository: QuizRepository
    
    init(repository: QuizRepository = BundleQuizRepository()) {
        self.repository = repository
    }
    
    func execute(for user: User) async throws -> [Quiz] {
        let allQuizzes = try await repository.getAll()
        return allQuizzes.filter { user.bookmarks.contains($0.id) }
    }
}
