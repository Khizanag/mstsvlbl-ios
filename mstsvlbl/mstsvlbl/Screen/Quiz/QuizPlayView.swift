//
//  QuizPlayView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct QuizPlayView: View {
    // MARK: - Properties
    @Environment(Coordinator.self) private var coordinator
    @State private var viewModel: QuizViewModel
    
    // MARK: - Init
    init(quiz: Quiz) {
        _viewModel = State(wrappedValue: QuizViewModel(quiz: quiz))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.currentQuestion != nil {
                VStack(spacing: 16) {
                    headerView
                        .padding(DesignBook.Layout.contentPadding)
                        .background(.thinMaterial)
                        .padding(-DesignBook.Layout.contentPadding)
                    
                    Spacer()
                    
                    questionView
                    
                    choicesView
                    
                    Spacer()
                    
                    footerView
                }
                
            } else {
                completedView
            }
        }
        .padding(DesignBook.Layout.contentPadding)
        .navigationTitle(viewModel.quiz?.title ?? "") // TODO: Fix
        .navigationBarBackButtonHidden()
        .onAppear { viewModel.startTimerIfNeeded() }
        .onDisappear { viewModel.stopTimer() }
    }
}

// MARK: - Subviews
private extension QuizPlayView {
    var headerView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                Text(viewModel.quiz?.title ?? "") // TODO: Fix
                    .font(DesignBook.Font.headline)
                
                Spacer()
                
                Text("Score: \(viewModel.score)/\(viewModel.totalQuestions)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            if let max = viewModel.quiz?.maxTimeSeconds, max > 0 {
                HStack {
                    Spacer()
                    Label("\(viewModel.remainingSeconds)s", systemImage: "timer")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            }
            
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
        VStack(alignment: .leading, spacing: DesignBook.Spacing.lg) {
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
        Button(
            action: {
                withAnimation(.easeInOut(duration: 0.25)) {
                    viewModel.goToNextQuestion()
                }
            },
            label: {
                Text(viewModel.isOnLastQuestion ? "Finish" : "Next")
                    .padding()
                    .contentShape(Rectangle())
                    .frame(maxWidth: .infinity)
            }
        )
        .frame(maxWidth: .infinity)
        .buttonStyle(.bordered)
        .disabled(!viewModel.hasAnsweredCurrent)
    }
    
    var completedView: some View {
        VStack(spacing: 16) {
            Text("All done!")
                .font(.title)
            
            Text("Your score: \(viewModel.score)/\(viewModel.totalQuestions)")
                .font(.title2)
            
            HStack(spacing: DesignBook.Spacing.lg) {
                Button {
                    viewModel.restart()
                } label: {
                    Text("Restart")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)

                Button {
                    coordinator.dismiss()
                } label: {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    QuizPlayView(quiz: .example)
}
