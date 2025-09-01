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

            let test = URL(string: "https://picsum.photos/800/600?random=6")!
            URLSession.shared.dataTask(with: test) { _, _, error in
                print("Connectivity test:", error as Any)
            }.resume()
        } catch {
            print("Error loading discover quizzes: \(error)")
            discoverQuizzes = []
        }
        
        isLoading = false
    }
}
