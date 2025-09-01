//
//  DiscoverViewModel.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation
import SwiftUI

@Observable
final class DiscoverViewModel {
    @Injected @ObservationIgnored private var getDiscoverQuizzesUseCase: GetDiscoverQuizzesUseCase
    
    private(set) var isLoading = false
    private(set) var discoverQuizzes: [Quiz] = []
    private(set) var categoryGroups: [CategoryGroup] = []

    @MainActor
    func loadQuizzesIfNeeded() async {
        guard discoverQuizzes.isEmpty else { return }
        isLoading = true
        
        do {
            discoverQuizzes = try await getDiscoverQuizzesUseCase.execute(limit: 20)
            createCategoryGroups()
        } catch {
            print("Error loading discover quizzes: \(error)")
            discoverQuizzes = []
        }
        
        isLoading = false
    }
    
    private func createCategoryGroups() {
        // Group quizzes by category
        let groupedQuizzes = Dictionary(grouping: discoverQuizzes) { $0.category }
        
        // Filter out nil categories and create CategoryGroup objects
        let validGroups = groupedQuizzes.compactMap { (category: Category?, quizzes: [Quiz]) -> CategoryGroup? in
            guard let category = category, !quizzes.isEmpty else { return nil }
            return CategoryGroup(category: category, quizzes: quizzes)
        }
        
        // Randomly select up to 5 categories
        let shuffledGroups = validGroups.shuffled()
        categoryGroups = Array(shuffledGroups.prefix(5))
    }
}

// MARK: - Category Group Model
struct CategoryGroup: Identifiable {
    let id = UUID()
    let category: Category
    let quizzes: [Quiz]
}
