//
//  QuizRepository.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

protocol QuizRepository {
    func loadQuiz() async throws -> Quiz
    func loadAllQuizzes() async throws -> [Quiz]
}

struct BundleQuizRepository: QuizRepository {
    private let resourceName = "Quizzes"
    private let resourceExtension = "json"

    func loadQuiz() async throws -> Quiz {
        let all = try await loadAllQuizzes()
        return all.first ?? makeSampleQuiz()
    }

    func loadAllQuizzes() async throws -> [Quiz] {
        if let url = Bundle.main.url(forResource: resourceName, withExtension: resourceExtension) {
            let data = try Data(contentsOf: url)
            // Try array first
            if let quizzes = try? JSONDecoder().decode([Quiz].self, from: data) {
                print("Did read the quizzes")
                return quizzes
            }
        }
        // Fallback to multiple samples
        return [
            makeSampleQuiz(),
            makeSampleQuizWith(title: "Swift Basics"),
            makeSampleQuizWith(title: "Math Warmup")
        ]
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

    private func makeSampleQuizWith(title: String) -> Quiz {
        let q = Question(
            id: UUID(),
            text: "Placeholder question for \(title)",
            choices: [
                Choice(id: UUID(), text: "Answer A", isCorrect: true),
                Choice(id: UUID(), text: "Answer B", isCorrect: false),
                Choice(id: UUID(), text: "Answer C", isCorrect: false)
            ]
        )
        return Quiz(title: title, questions: [q])
    }
}
