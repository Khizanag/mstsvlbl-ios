//
//  QuizDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking

@MainActor
final class QuizDeepLinkSubscriber: DeepLinkSubscriber {
    @Injected private var repository: QuizRepository
    
    let subscribedPath = "quiz"
    
    func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
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
            
            let navigatorView = NavigatorView {
                page()
            }
            
            let hostingController = UIHostingController(rootView: navigatorView)
            hostingController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            
            if let topmostViewController = UIApplication.shared.keyWindow?.topmostViewController {
                topmostViewController.present(hostingController, animated: true)
            } else if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.rootViewController = hostingController
                keyWindow.makeKeyAndVisible()
            }
        } catch {
            print("❌ QuizDeepLinkSubscriber: Failed to fetch quiz: \(error)")
        }
    }
}
