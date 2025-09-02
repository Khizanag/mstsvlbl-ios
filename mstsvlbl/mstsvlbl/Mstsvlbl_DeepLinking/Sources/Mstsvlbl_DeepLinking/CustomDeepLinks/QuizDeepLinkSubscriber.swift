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
    
    public init(navigationHandler: NavigationHandler, dataProvider: DataProvider) async {
        self.navigationHandler = navigationHandler
        self.dataProvider = dataProvider
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        print("🎯 QuizDeepLinkSubscriber: Handling quiz deep link")
        
        await handleQuizDeepLink(deepLink)
    }
    
    private func handleQuizDeepLink(_ deepLink: any DeepLink) async {
        print("🎯 QuizDeepLinkSubscriber: Processing quiz deep link with path: \(deepLink.path)")
        print("🎯 QuizDeepLinkSubscriber: Parameters: \(deepLink.parameters)")
        print("🎯 QuizDeepLinkSubscriber: Navigation handler: \(type(of: navigationHandler))")
        print("🎯 QuizDeepLinkSubscriber: Data provider: \(type(of: dataProvider))")
    }
}
