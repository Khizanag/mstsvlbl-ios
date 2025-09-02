//
//  QuizDeepLinkSubscriber.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

@MainActor
public final class QuizDeepLinkSubscriber<NavigationHandler, DataProvider>: GenericDeepLinkSubscriber {
    public let id = "QuizDeepLinkSubscriber"
    public let subscribedPath = "quiz"
    
    public let navigationHandler: NavigationHandler
    public let dataProvider: DataProvider
    
    public nonisolated init(navigationHandler: NavigationHandler, dataProvider: DataProvider) {
        self.navigationHandler = navigationHandler
        self.dataProvider = dataProvider
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        print("🎯 QuizDeepLinkSubscriber: Handling quiz deep link")
        
        await handleQuizDeepLink(deepLink)
    }
    
    private func handleQuizDeepLink(_ deepLink: any DeepLink) async {
        // This is a generic implementation that can be extended by the app
        print("🎯 QuizDeepLinkSubscriber: Generic handling for quiz deep link")
    }
}
