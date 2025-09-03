//
//  QuizDeepLinkHandler.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking

// MARK: - Parameters
struct QuizDeepLinkParameters {
    let id: String
    let action: Action

    enum Action: String {
        case start
        case play
        case overview
    }
}

// MARK: - DeepLinkHandler
@MainActor
final class QuizDeepLinkHandler: DeepLinkHandler {
    typealias Parameters = QuizDeepLinkParameters

    @Injected private var repository: QuizRepository
    
    let host = "quiz"
    
    func handle(_ parameters: Parameters, context: DeepLinkContext) async -> DeepLinkResult {
        do {
            let quizzes = try await repository.get(by: [parameters.id])
            guard let quiz = quizzes.first else { return .failure(.routingFailed) }
            
            let page: Page = switch parameters.action {
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
    
    nonisolated func mapParametersToDeepLinkParameters(_ parameters: [String: String]) -> Parameters? {
        guard let id = parameters["id"],
              let actionRawValue = parameters["action"],
              let action = Parameters.Action(rawValue: actionRawValue)
        else { return nil }
        
        return Parameters(id: id, action: action)
    }
}
