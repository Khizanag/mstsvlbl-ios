//
//  QuizPlayView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct QuizPlayView: View {
    let quiz: Quiz
    @State private var viewModel: QuizViewModel

    init(quiz: Quiz) {
        _viewModel = StateObject(wrappedValue: QuizViewModel(quiz: quiz))
        self.quiz = quiz
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let currentQuestion = viewModel.currentQuestion {
                Text(quiz.title)
                    .font(DesignBook.Font.headline)

                ProgressView(value: Double(viewModel.answeredCount), total: Double(viewModel.totalQuestions))
                    .animation(.easeInOut(duration: 0.25), value: viewModel.answeredCount)

                Text(currentQuestion.text)
                    .font(DesignBook.Font.title2)

                VStack(alignment: .leading, spacing: 12) {
                    ForEach(currentQuestion.choices, id: \.id) { choice in
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
            } else {
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
        .padding(DesignBook.Layout.contentPadding)
        .navigationTitle(quiz.title)
        .task {
            await viewModel.loadQuizzes()
        }
    }
}

#Preview {
    QuizPlayView(quiz: Quiz(title: "Sample", questions: []))
}
