//
//  GetDiscoverQuizzesUseCase.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

// MARK: - Protocol
protocol GetDiscoverQuizzesUseCase {
    func execute(limit: Int) async throws -> [Quiz]
}

// MARK: - Default Implementation
final class DefaultGetDiscoverQuizzesUseCase: GetDiscoverQuizzesUseCase {
    @Injected private var repository: QuizRepository
    
    func execute(limit: Int) async throws -> [Quiz] {
        print("🔍 GetDiscoverQuizzesUseCase: Starting execution with limit: \(limit)")
        let all = try await repository.getAll()
        print("🔍 GetDiscoverQuizzesUseCase: Got \(all.count) quizzes from repository")
        
        let result = Array(all.shuffled().prefix(limit))
        print("🔍 GetDiscoverQuizzesUseCase: Returning \(result.count) quizzes")
        
        for quiz in result {
            print("🔍 GetDiscoverQuizzesUseCase: Quiz '\(quiz.title)' has coverUrl: \(quiz.coverUrl)")
        }
        
        return result
    }
}
