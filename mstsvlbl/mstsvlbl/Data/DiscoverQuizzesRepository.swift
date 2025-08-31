//
//  DiscoverQuizzesRepository.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

protocol DiscoverQuizzesRepository {
    func getDiscoverQuizzes(limit: Int) async throws -> [Quiz]
}

struct RandomDiscoverQuizzesRepository: DiscoverQuizzesRepository {
    private let baseRepository: QuizRepository
    
    init(baseRepository: QuizRepository = BundleQuizRepository()) {
        self.baseRepository = baseRepository
    }
    
    func getDiscoverQuizzes(limit: Int) async throws -> [Quiz] {
        let all = try await baseRepository.getAll()
        return Array(all.shuffled().prefix(limit))
    }
}
