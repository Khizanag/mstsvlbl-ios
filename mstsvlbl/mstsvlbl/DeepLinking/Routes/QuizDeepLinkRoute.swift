//
//  QuizDeepLinkRoute.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public final class QuizDeepLinkRoute: DeepLinkRoute {
    public init() {}
    
    public func route(_ deepLink: any DeepLink) -> DeepLinkDestination? {
        guard let quizDeepLink = deepLink as? QuizDeepLink else {
            return nil
        }
        
        return .quiz(id: quizDeepLink.id, action: quizDeepLink.action)
    }
}
