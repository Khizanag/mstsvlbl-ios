//
//  Page.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

enum Page: Hashable {
    case list
    case play(Quiz)

    @ViewBuilder
    func callAsFunction() -> some View {
        switch self {
        case .list:
            QuizListView()
        case .play(let quiz):
            QuizPlayView(quiz: quiz)
        }
    }
}

// MARK: - Identifiable
extension Page: Identifiable {
    var id: String {
        switch self {
        case .list:
            "list"
        case .play(let quiz):
            "play_\(quiz.id)"
        }
    }
}
