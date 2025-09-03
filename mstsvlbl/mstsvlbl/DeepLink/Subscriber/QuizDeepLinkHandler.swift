//
//  QuizDeepLinkHandler.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking

struct QuizDeepLinkParameters {
    let id: String
    let action: Action

    enum Action: String {
        case start
        case play
        case overview
    }
}

@MainActor
final class QuizDeepLinkHandler: DeepLinkHandler {
    typealias Parameters = QuizDeepLinkParameters

    @Injected private var repository: QuizRepository
    
    let host = "quiz"
    
    func handle(_ parameters: [String: String], context: DeepLinkContext) async -> DeepLinkResult {
        guard let quizDeepLink = mapParametersToDeepLinkParameters(parameters) else {
            return .failure(.missingRequiredParameters)
        }
        
        do {
            let quizzes = try await repository.get(by: [quizDeepLink.id])
            guard let quiz = quizzes.first else { return .failure(.routingFailed) }
            
            let page: Page = switch quizDeepLink.action {
            case .start, .play:
                .play(quiz)
            case .overview:
                .overview(quiz)
            }
            
            presentViewOnTop(page())
            return .success
        } catch {
            print("❌ QuizDeepLinkHandler: Failed to fetch quiz: \(error)")
            return .failure(.routingFailed)
        }
    }
    
    func mapParametersToDeepLinkParameters(_ parameters: [String: String]) -> Parameters? {
        guard let id = parameters["id"],
              let actionRawValue = parameters["action"],
              let action = Parameters.Action(rawValue: actionRawValue)
        else { return nil }
        
        return Parameters(id: id, action: action)
    }
}
