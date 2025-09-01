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
        let all = try await repository.getAll()
        return Array(all.shuffled().prefix(limit))
    }
}
