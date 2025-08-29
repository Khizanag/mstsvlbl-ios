//
//  QuizListView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct QuizListView: View {
    @StateObject private var viewModel = QuizListViewModel()
    @State private var previewQuiz: Quiz?

    private let columns = [
        GridItem(
            .adaptive(
                minimum: DesignBook.Layout.gridMinWidth,
                maximum: DesignBook.Layout.gridMaxWidth
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
                        NavigationLink {
                            QuizPlayView(quiz: quiz)
                        } label: {
                            QuizCardView(quiz: quiz)
                        }
                        .buttonStyle(.plain)
                        .simultaneousGesture(
                            LongPressGesture(minimumDuration: 0.4).onEnded { _ in
                                previewQuiz = quiz
                            }
                        )
                    }
                }
//                .padding(16)
            }
            .navigationTitle("Quizzes")
            .task { await viewModel.load() }
            .sheet(item: $previewQuiz) { quiz in
                QuizPreviewView(quiz: quiz)
            }
        }
    }
}

#Preview {
    QuizListView()
}


