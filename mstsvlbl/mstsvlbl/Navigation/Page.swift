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
    case overview(Quiz)

    @ViewBuilder
    func callAsFunction(wrappedInNavigatorView: Bool = false) -> some View {
        if wrappedInNavigatorView {
            NavigatorView {
                content
            }
            .onAppear {
                print("Wrapped in navigator:  \(wrappedInNavigatorView) ")
            }
        } else {
            content
                .onAppear {
                    print("Wrapped in navigator:  \(wrappedInNavigatorView) ")
                }
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
        case .overview(let quiz):
            "overview_\(quiz.id)"
        }
    }
    
    @ViewBuilder
    var content: some View {
        switch self {
        case .list:
            QuizListView()
        case .play(let quiz):
            QuizPlayView(quiz: quiz)
        case .overview(let quiz):
            QuizOverviewView(quiz: quiz)
        }
    }
}
