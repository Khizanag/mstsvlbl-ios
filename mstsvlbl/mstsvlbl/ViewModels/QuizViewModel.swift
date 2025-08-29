//
//  QuizViewModel.swift
//  mstsvlbl
//
//  Created by Assistant on 29.08.25.
//

import Foundation
import SwiftUI

@MainActor
final class QuizViewModel: ObservableObject {
    @Published private(set) var quiz: Quiz?
    @Published private(set) var currentQuestionIndex: Int = 0
    @Published private(set) var score: Int = 0
    @Published private(set) var hasAnsweredCurrent: Bool = false
    @Published private(set) var selectedChoice: Choice?

    private let repository: QuizRepository

    init(repository: QuizRepository = BundleQuizRepository()) {
        self.repository = repository
    }

    var quizTitle: String {
        quiz?.title ?? ""
    }

    var totalQuestions: Int {
        quiz?.questions.count ?? 0
    }

    var currentQuestion: Question? {
        guard let quiz else { return nil }
        guard currentQuestionIndex < quiz.questions.count else { return nil }
        return quiz.questions[currentQuestionIndex]
    }

    var isOnLastQuestion: Bool {
        guard let quiz else { return false }
        return currentQuestionIndex == quiz.questions.count - 1
    }

    func loadQuizzes() async {
        do {
            let loaded = try await repository.loadQuiz()
            self.quiz = loaded
            self.currentQuestionIndex = 0
            self.score = 0
            self.hasAnsweredCurrent = false
            self.selectedChoice = nil
        } catch {
            print("Failed to load quiz: \(error)")
        }
    }

    func select(choice: Choice) {
        guard let question = currentQuestion else { return }
        guard !hasAnsweredCurrent else { return }

        selectedChoice = choice
        hasAnsweredCurrent = true

        if let correct = question.choices.first(where: { $0.isCorrect }), choice == correct {
            score += 1
        }
    }

    func goToNextQuestion() {
        guard let quiz else { return }
        guard hasAnsweredCurrent else { return }

        if currentQuestionIndex < quiz.questions.count - 1 {
            currentQuestionIndex += 1
            hasAnsweredCurrent = false
            selectedChoice = nil
        } else {
            currentQuestionIndex = quiz.questions.count
        }
    }

    func restart() {
        currentQuestionIndex = 0
        score = 0
        hasAnsweredCurrent = false
        selectedChoice = nil
    }

    func backgroundColor(for choice: Choice) -> Color {
        guard hasAnsweredCurrent, let question = currentQuestion else {
            return Color.gray.opacity(0.1)
        }
        let isCorrect = question.choices.first(where: { $0.isCorrect }) == choice
        if selectedChoice == choice {
            return isCorrect ? Color.green.opacity(0.25) : Color.red.opacity(0.25)
        }
        return isCorrect ? Color.green.opacity(0.15) : Color.gray.opacity(0.1)
    }
}


