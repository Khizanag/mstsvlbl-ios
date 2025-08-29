//
//  QuizRepository.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

protocol QuizRepository {
    func getAll() async throws -> [Quiz]
}

struct BundleQuizRepository: QuizRepository {
    private let resourceName = "Quizzes"
    private let resourceExtension = "json"

    func getAll() async throws -> [Quiz] {
        if let url = Bundle.main.url(forResource: resourceName, withExtension: resourceExtension),
           let data = try? Data(contentsOf: url),
           let quizzes = try? JSONDecoder().decode([Quiz].self, from: data)
        {
            return quizzes
        }
        
        // TODO: Return error
        return []
    }
}
