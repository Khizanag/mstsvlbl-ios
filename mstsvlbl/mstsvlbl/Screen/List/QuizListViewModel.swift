//
//  QuizListViewModel.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation
import Observation

@MainActor
@Observable
final class QuizListViewModel {
    private(set) var quizzes: [Quiz] = []
    private(set) var isLoading = false

    private let repository: QuizRepository

    init(repository: QuizRepository = BundleQuizRepository()) {
        self.repository = repository
    }

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            quizzes = try await repository.loadAllQuizzes()
        } catch {
            print("Failed to load quizzes: \(error)")
            quizzes = []
        }
    }
}
