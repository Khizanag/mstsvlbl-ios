//
//  QuizRepository.swift
//  mstsvlbl
//
//  Created by Assistant on 29.08.25.
//

import Foundation

protocol QuizRepository {
    func loadQuiz() async throws -> Quiz
}

struct BundleQuizRepository: QuizRepository {
    let resourceName: String = "Quizzes"
    let resourceExtension: String = "json"

    func loadQuiz() async throws -> Quiz {
        if let url = Bundle.main.url(forResource: resourceName, withExtension: resourceExtension) {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Quiz.self, from: data)
        }
        // Fallback to a built-in sample to keep the app working on all platforms
        return makeSampleQuiz()
    }

    private func makeSampleQuiz() -> Quiz {
        let q1 = Question(
            id: UUID(),
            text: "What is 2 + 2?",
            choices: [
                Choice(id: UUID(), text: "3", isCorrect: false),
                Choice(id: UUID(), text: "4", isCorrect: true),
                Choice(id: UUID(), text: "5", isCorrect: false)
            ]
        )
        let q2 = Question(
            id: UUID(),
            text: "Which language is used for SwiftUI apps?",
            choices: [
                Choice(id: UUID(), text: "Objective-C", isCorrect: false),
                Choice(id: UUID(), text: "Swift", isCorrect: true),
                Choice(id: UUID(), text: "Kotlin", isCorrect: false)
            ]
        )
        return Quiz(title: "Sample Quiz", questions: [q1, q2])
    }
}


