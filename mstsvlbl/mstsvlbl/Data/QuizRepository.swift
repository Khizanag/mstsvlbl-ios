//
//  QuizRepository.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

protocol QuizRepository {
    func getAllQuizzes() async throws -> [Quiz]
}

struct BundleQuizRepository: QuizRepository {
    private let resourceName = "Quizzes"
    private let resourceExtension = "json"

    func getAllQuizzes() async throws -> [Quiz] {
        if let url = Bundle.main.url(forResource: resourceName, withExtension: resourceExtension) {
            let data = try Data(contentsOf: url)
            
            if let quizzes = try? JSONDecoder().decode([Quiz].self, from: data) {
                print("Did read the quizzes: \(quizzes)")
                return quizzes
            }
        }
        
        // TODO: Return error
        return []
    }
}
