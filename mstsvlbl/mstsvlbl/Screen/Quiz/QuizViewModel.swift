//
//  QuizViewModel.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation
import SwiftUI
import Observation

@MainActor
@Observable
final class QuizViewModel {
    private(set) var quiz: Quiz?
    private(set) var currentQuestionIndex = 0
    private(set) var score = 0
    private(set) var hasAnsweredCurrent = false
    private(set) var selectedChoice: Choice?
    private(set) var remainingSeconds: Int = 0
    private var timer: Timer?

    private let repository: QuizRepository

    init(repository: QuizRepository = BundleQuizRepository()) {
        self.repository = repository
    }

    init(quiz: Quiz, repository: QuizRepository = BundleQuizRepository()) {
        self.repository = repository
        self.quiz = quiz
        self.currentQuestionIndex = 0
        self.score = 0
        self.hasAnsweredCurrent = false
        self.selectedChoice = nil
        if let max = quiz.maxTimeSeconds {
            remainingSeconds = max
        }
    }

    var quizTitle: String {
        quiz?.title ?? ""
    }

    var totalQuestions: Int {
        quiz?.questions.count ?? 0
    }

    var answeredCount: Int {
        currentQuestionIndex + (hasAnsweredCurrent ? 1 : 0)
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
        if let quiz, let max = quiz.maxTimeSeconds { remainingSeconds = max }
        startTimerIfNeeded()
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

    func startTimerIfNeeded() {
        guard timer == nil, let quiz, let max = quiz.maxTimeSeconds, max > 0 else { return }
        if remainingSeconds <= 0 { remainingSeconds = max }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            } else {
                self.timer?.invalidate()
                self.timer = nil
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
