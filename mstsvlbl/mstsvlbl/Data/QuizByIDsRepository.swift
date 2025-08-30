//
//  QuizByIDsRepository.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

protocol QuizByIDsRepository {
    func get(by ids: [String]) async throws -> [Quiz]
}

struct FilteringQuizByIDsRepository: QuizByIDsRepository {
    private let baseRepository: QuizRepository

    init(baseRepository: QuizRepository = BundleQuizRepository()) {
        self.baseRepository = baseRepository
    }

    func get(by ids: [String]) async throws -> [Quiz] {
        let all = try await baseRepository.getAll()
        let wanted = Set(ids)
        return all.filter { wanted.contains($0.id) }
    }
}


