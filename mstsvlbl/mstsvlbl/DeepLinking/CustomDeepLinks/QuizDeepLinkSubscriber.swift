//
//  QuizDeepLinkSubscriber.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

@MainActor
public final class QuizDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "QuizDeepLinkSubscriber"
    public let subscribedPath = "quiz"
    
    private let coordinator: Coordinator
    private let quizRepository: QuizRepository
    
    public init(coordinator: Coordinator, quizRepository: QuizRepository) {
        self.coordinator = coordinator
        self.quizRepository = quizRepository
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) {
        guard let quizDeepLink = deepLink as? QuizDeepLink else { return }
        
        print("🎯 QuizDeepLinkSubscriber: Handling quiz deep link with ID: \(quizDeepLink.id), action: \(quizDeepLink.action)")
        
        Task {
            await loadAndNavigateToQuiz(id: quizDeepLink.id, action: quizDeepLink.action)
        }
    }
    
    private func loadAndNavigateToQuiz(id: String, action: String) async {
        do {
            let quizzes = try await quizRepository.get(by: [id])
            guard let quiz = quizzes.first else {
                print("❌ QuizDeepLinkSubscriber: Quiz '\(id)' not found")
                return
            }
            navigateToQuiz(quiz, action: action)
        } catch {
            print("❌ QuizDeepLinkSubscriber: Failed to load quiz '\(id)': \(error)")
        }
    }
    
    private func navigateToQuiz(_ quiz: Quiz, action: String) {
        switch action {
        case "start", "resume":
            coordinator.fullScreenCover(.play(quiz))
        case "view":
            coordinator.fullScreenCover(.overview(quiz))
        default:
            coordinator.fullScreenCover(.overview(quiz))
        }
    }
}
