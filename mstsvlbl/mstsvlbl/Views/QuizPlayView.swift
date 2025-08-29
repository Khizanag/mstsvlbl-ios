//
//  QuizPlayView.swift
//  mstsvlbl
//
//  Created by Assistant on 29.08.25.
//

import SwiftUI

struct QuizPlayView: View {
    let quiz: Quiz
    @StateObject private var viewModel = QuizViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let currentQuestion = viewModel.currentQuestion {
                Text(quiz.title)
                    .font(.headline)

                ProgressView(value: Double(viewModel.currentQuestionIndex + 1), total: Double(viewModel.totalQuestions))

                Text(currentQuestion.text)
                    .font(.title2)

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
                            .padding()
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
                        viewModel.goToNextQuestion()
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
        .padding()
        .navigationTitle(quiz.title)
        .task {
            await viewModel.loadQuizzes()
        }
    }
}

#Preview {
    QuizPlayView(quiz: Quiz(title: "Sample", questions: []))
}


