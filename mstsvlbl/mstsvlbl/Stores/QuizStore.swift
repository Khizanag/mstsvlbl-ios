//
//  QuizStore.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Quiz Store
@MainActor
@Observable
public final class QuizStore {
    
    // MARK: - Properties
    public private(set) var quizzes: [Quiz] = []
    public private(set) var isLoading = false
    public private(set) var error: Error?
    
    private let repository: QuizRepository
    
    // MARK: - Initialization
    public init(repository: QuizRepository = LocalQuizRepository()) {
        self.repository = repository
    }
    
    // MARK: - Public Methods
    
    /// Load all quizzes
    public func loadQuizzes() async {
        isLoading = true
        error = nil
        
        do {
            quizzes = try await repository.getAll()
        } catch {
            self.error = error
            print("❌ Failed to load quizzes: \(error)")
        }
        
        isLoading = false
    }
    
    /// Get a specific quiz by ID
    public func getQuiz(by id: String) -> Quiz? {
        quizzes.first { $0.id == id }
    }
    
    /// Get quizzes by category
    public func getQuizzes(for category: Category) -> [Quiz] {
        quizzes.filter { $0.category == category }
    }
    
    /// Search quizzes by title
    public func searchQuizzes(query: String) -> [Quiz] {
        guard !query.isEmpty else { return quizzes }
        return quizzes.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }
}
