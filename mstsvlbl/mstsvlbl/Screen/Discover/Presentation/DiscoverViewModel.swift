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

    @MainActor
    func loadQuizzesIfNeeded() async {
        guard discoverQuizzes.isEmpty else { return }
        isLoading = true
        
        do {
            discoverQuizzes = try await getDiscoverQuizzesUseCase.execute(limit: 5)
        } catch {
            print("Error loading discover quizzes: \(error)")
            discoverQuizzes = []
        }
        
        isLoading = false
    }
}
