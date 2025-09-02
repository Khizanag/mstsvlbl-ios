//
//  QuizDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import UIKit
import Mstsvlbl_Core_DeepLinking

@MainActor
public final class QuizDeepLinkSubscriber<DataProvider>: DeepLinkSubscriber {
    public let id = "QuizDeepLinkSubscriber"
    public let subscribedPath = "quiz"
    
    public let navigationHandler: UIWindow
    public let dataProvider: DataProvider
    
    public init(navigationHandler: UIWindow, dataProvider: DataProvider) async {
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
        
        // Example of how to add content directly over the window
        if let quizId = deepLink.parameters["id"] {
            print("🎯 QuizDeepLinkSubscriber: Opening quiz with ID: \(quizId)")
            // Here you can add a view controller or view directly to the window
            // For example: navigationHandler.addSubview(someView)
        }
    }
}
