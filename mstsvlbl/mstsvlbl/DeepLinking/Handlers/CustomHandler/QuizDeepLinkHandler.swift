//
//  QuizDeepLinkHandler.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public final class QuizDeepLinkHandler: DeepLinkHandler {
    public typealias LinkType = QuizDeepLink
    
    public let metadata: DeepLinkMetadata
    
    public init() {
        self.metadata = DeepLinkMetadata(
            id: "quiz_handler",
            type: "quiz",
            priority: .high,
            requiresAuthentication: false,
            supportedPlatforms: [.iOS, .macOS],
            version: "1.0.0",
            description: "Handles quiz-related deep links"
        )
    }
    
    public func handle(_ deepLink: QuizDeepLink, context: DeepLinkContext) async -> DeepLinkResult {
        // The actual navigation is handled by DeepLinkManager through the navigation coordinator
        // This handler validates and processes the deep link, but navigation is coordinated elsewhere
        
        // Log the deep link for debugging
        print("🎯 QuizDeepLinkHandler: Processing quiz deep link - ID: \(deepLink.id), Action: \(deepLink.action)")
        
        // Return success - the DeepLinkManager will handle the actual navigation
        return .success(deepLink)
    }
    
    public func validate(_ deepLink: QuizDeepLink) -> DeepLinkError? {
        deepLink.id.isEmpty ? .missingRequiredParameters : nil
    }
}
