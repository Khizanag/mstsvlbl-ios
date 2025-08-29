//
//  QuizPlayView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct QuizPlayView: View {
    @State private var viewModel: QuizViewModel
    
    let quiz: Quiz

    init(quiz: Quiz) {
        _viewModel = State(wrappedValue: QuizViewModel(quiz: quiz))
        self.quiz = quiz
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.currentQuestion != nil {
                headerView

                questionView

                choicesView

                footerView
            } else {
                completedView
            }
        }
        .padding(DesignBook.Layout.contentPadding)
        .navigationTitle(quiz.title)
    }

}

// MARK: - Subviews
private extension QuizPlayView {
    var headerView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(quiz.title)
                .font(DesignBook.Font.headline)

            ProgressView(value: Double(viewModel.answeredCount), total: Double(viewModel.totalQuestions))
                .animation(.easeInOut(duration: 0.25), value: viewModel.answeredCount)
        }
    }

    @ViewBuilder
    var questionView: some View {
        if let text = viewModel.currentQuestion?.text {
            Text(text)
                .font(DesignBook.Font.title2)
        }
    }

    var choicesView: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let choices = viewModel.currentQuestion?.choices {
                ForEach(choices, id: \.id) { choice in
                    Button {
                        viewModel.select(choice: choice)
                    } label: {
                        HStack {
                            Text(choice.text)
                                .foregroundStyle(.primary)
                            Spacer()
                        }
                        .padding(DesignBook.Spacing.lg)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.backgroundColor(for: choice))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    .disabled(viewModel.hasAnsweredCurrent)
                }
            }
        }
    }

    var footerView: some View {
        HStack {
            Text("Score: \(viewModel.score)/\(viewModel.totalQuestions)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            Button(viewModel.isOnLastQuestion ? "Finish" : "Next") {
                withAnimation(.easeInOut(duration: 0.25)) {
                    viewModel.goToNextQuestion()
                }
            }
            .disabled(!viewModel.hasAnsweredCurrent)
        }
    }

    var completedView: some View {
        VStack(spacing: 16) {
            Text("All done!")
                .font(.title)

            Text("Your score: \(viewModel.score)/\(viewModel.totalQuestions)")
                .font(.title2)

            Button("Restart") {
                viewModel.restart()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    QuizPlayView(quiz: Quiz(title: "Sample", questions: []))
}
