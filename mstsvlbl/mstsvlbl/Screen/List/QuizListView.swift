//
//  QuizListView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Observation

import SwiftUI

struct QuizListView: View {
    @State private var viewModel = QuizListViewModel()
    @Environment(QuizFlowCoordinator.self) private var coordinator

    private let columns = [
        GridItem(
            .adaptive(
                minimum: DesignBook.Layout.gridMinWidth,
                maximum: .infinity
            ),
            spacing: DesignBook.Layout.gridSpacing,
            alignment: .top
        )
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: DesignBook.Layout.gridSpacing) {
                    ForEach(viewModel.quizzes) { quiz in
                        makeItemView(quiz: quiz)
                    }
                }
                .padding(DesignBook.Spacing.lg)
            }
            .navigationTitle("Quizzes")
            .task { await viewModel.load() }
        }
    }
}

// MARK: - Components
private extension QuizListView {
    func makeItemView(quiz: Quiz) -> some View {
        Button {
            coordinator.push(.play(quiz))
        } label: {
            QuizCardView(quiz: quiz)
        }
        .buttonStyle(.plain)
        .contextMenu {
            Button {
                // TODO: Fix
//                coordinator.present(quiz)
            } label: {
                Label("Preview", systemImage: "eye")
            }
        }
    }
}


#Preview {
    QuizListView()
}
