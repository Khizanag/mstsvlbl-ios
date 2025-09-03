//
//  QuizDeepLinkHandler.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking

@MainActor
final class QuizDeepLinkHandler: DeepLinkHandler {
    @Injected private var repository: QuizRepository
    
    let subscribedPath = "quiz"
    
    func handle(_ deepLink: DeepLink, context: DeepLinkContext) async {
        guard let quizId = deepLink.parameters["id"] else { return }
        
        do {
            let quizzes = try await repository.get(by: [quizId])
            guard let quiz = quizzes.first else { return }
            
            let action = deepLink.parameters["action"] ?? "overview"
            
            let page: Page
            switch action {
            case "start", "play":
                page = .play(quiz)
            case "overview":
                page = .overview(quiz)
            default:
                page = .overview(quiz)
            }
            
            presentViewOnTop(page())
        } catch {
            print("❌ QuizDeepLinkHandler: Failed to fetch quiz: \(error)")
        }
    }
}
