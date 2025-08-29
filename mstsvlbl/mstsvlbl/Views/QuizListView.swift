//
//  QuizListView.swift
//  mstsvlbl
//
//  Created by Assistant on 29.08.25.
//

import SwiftUI

struct QuizListView: View {
    @StateObject private var viewModel = QuizListViewModel()

    private let columns = [
        GridItem(.adaptive(minimum: 200, maximum: 320), spacing: 16, alignment: .top)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.quizzes) { quiz in
                        NavigationLink {
                            QuizPlayView(quiz: quiz)
                        } label: {
                            QuizCardView(quiz: quiz)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(16)
            }
            .navigationTitle("Quizzes")
            .task { await viewModel.load() }
        }
    }
}

#Preview {
    QuizListView()
}


