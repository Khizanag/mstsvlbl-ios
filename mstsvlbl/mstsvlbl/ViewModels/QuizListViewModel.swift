//
//  QuizListViewModel.swift
//  mstsvlbl
//
//  Created by Assistant on 29.08.25.
//

import Foundation

@MainActor
final class QuizListViewModel: ObservableObject {
    @Published private(set) var quizzes: [Quiz] = []
    @Published private(set) var isLoading = false

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


