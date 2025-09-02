//
//  QuizViewModel.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation
import SwiftUI
import Observation
#if os(iOS)
import AudioToolbox
#elseif os(macOS)
import AppKit
#endif

@Observable
final class QuizViewModel {
    private(set) var quiz: Quiz?
    @Injected @ObservationIgnored private var repository: QuizRepository
    
    private var questionsWithRandomizedChoices: [Question] = []
    private(set) var currentQuestionIndex = 0
    private(set) var score = 0
    private(set) var hasAnsweredCurrent = false
    private(set) var selectedChoice: Choice?
    private(set) var remainingSeconds: Int = 0
    private var timer: Timer?
    private var autoAdvanceTimer: Timer?
    
    // Settings
    @AppStorage("autoAdvanceEnabled") @ObservationIgnored private var autoAdvanceEnabled = false
    @AppStorage("showTimerEnabled") @ObservationIgnored private var showTimerEnabled = true
    @AppStorage("hapticsEnabled") @ObservationIgnored private var hapticsEnabled = true
    @AppStorage("soundEnabled") @ObservationIgnored private var soundEnabled = true

    init() {}

    init(quiz: Quiz) {
        self.quiz = quiz
        self.questionsWithRandomizedChoices = randomizeChoicesForQuestions(quiz.questions)
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
        questionsWithRandomizedChoices.count
    }

    var answeredCount: Int {
        currentQuestionIndex + (hasAnsweredCurrent ? 1 : 0)
    }

    var currentQuestion: Question? {
        guard currentQuestionIndex < questionsWithRandomizedChoices.count else { return nil }
        return questionsWithRandomizedChoices[currentQuestionIndex]
    }

    var isOnLastQuestion: Bool {
        return currentQuestionIndex == questionsWithRandomizedChoices.count - 1
    }
    
    var shouldShowTimer: Bool {
        guard let quiz, let maxTime = quiz.maxTimeSeconds, maxTime > 0 else { return false }
        return showTimerEnabled
    }

    func select(choice: Choice) {
        guard let question = currentQuestion else { return }
        guard !hasAnsweredCurrent else { return }

        selectedChoice = choice
        hasAnsweredCurrent = true

        let isCorrect = question.choices.first(where: { $0.isCorrect }) == choice
        if isCorrect {
            score += 1
        }
        
        // Haptic feedback
        if hapticsEnabled {
            #if os(iOS)
            let impactFeedback = UIImpactFeedbackGenerator(style: isCorrect ? .light : .medium)
            impactFeedback.impactOccurred()
            #endif
        }
        
        // Sound effects
        if soundEnabled {
            #if os(iOS)
            if isCorrect {
                AudioServicesPlaySystemSound(1057) // Correct sound
            } else {
                AudioServicesPlaySystemSound(1053) // Incorrect sound
            }
            #elseif os(macOS)
            if isCorrect {
                NSSound.beep()
            } else {
                NSSound.beep()
            }
            #endif
        }
        
        // Auto-advance to next question after a delay
        if autoAdvanceEnabled && !isOnLastQuestion {
            autoAdvanceTimer?.invalidate()
            autoAdvanceTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] _ in
                withAnimation(.easeInOut(duration: DesignBook.Duration.normal)) {
                    self?.goToNextQuestion()
                }
            }
        }
    }

    func goToNextQuestion() {
        guard hasAnsweredCurrent else { return }
        
        // Clear auto-advance timer
        autoAdvanceTimer?.invalidate()
        autoAdvanceTimer = nil

        if currentQuestionIndex < questionsWithRandomizedChoices.count - 1 {
            currentQuestionIndex += 1
            hasAnsweredCurrent = false
            selectedChoice = nil
        } else {
            currentQuestionIndex = questionsWithRandomizedChoices.count
        }
    }

    func restart() {
        if let quiz {
            questionsWithRandomizedChoices = randomizeChoicesForQuestions(quiz.questions)
        }
        currentQuestionIndex = 0
        score = 0
        hasAnsweredCurrent = false
        selectedChoice = nil
        if let quiz, let max = quiz.maxTimeSeconds { remainingSeconds = max }
        startTimerIfNeeded()
    }

    func backgroundColor(for choice: Choice) -> Color {
        guard hasAnsweredCurrent, let question = currentQuestion else {
            return DesignBook.Color.Interaction.optionIdle
        }
        let isCorrect = question.choices.first(where: { $0.isCorrect }) == choice
        if selectedChoice == choice {
            return isCorrect ? DesignBook.Color.Interaction.correct : DesignBook.Color.Interaction.incorrect
        }
        return isCorrect ? DesignBook.Color.Interaction.correctFaint : DesignBook.Color.Interaction.optionIdle
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
        autoAdvanceTimer?.invalidate()
        autoAdvanceTimer = nil
    }
    
    private func randomizeChoicesForQuestions(_ questions: [Question]) -> [Question] {
        questions.map { question in
            Question(
                id: question.id,
                text: question.text,
                choices: question.choices.shuffled()
            )
        }
    }
}
