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
    @AppStorage("autoAdvanceEnabled") private var autoAdvanceEnabled = false
    @AppStorage("confirmBeforeExit") private var confirmBeforeExit = true
    @State private var showingExitConfirmation = false
    
    // MARK: - Init
    init(quiz: Quiz) {
        _viewModel = State(wrappedValue: QuizViewModel(quiz: quiz))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.lg) {
            if viewModel.currentQuestion != nil {
                VStack(spacing: DesignBook.Spacing.lg) {
                    headerView
                        .padding(DesignBook.Spacing.lg)
                        .background(.thinMaterial)
                        .padding(-DesignBook.Spacing.lg)
                    
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
        .padding(DesignBook.Spacing.lg)
        .navigationTitle(viewModel.quiz?.title ?? "") // TODO: Fix
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Back") {
                    if confirmBeforeExit && viewModel.currentQuestionIndex > 0 {
                        showingExitConfirmation = true
                    } else {
                        coordinator.dismiss()
                    }
                }
            }
        }
        .confirmationDialog(
            "Exit Quiz",
            isPresented: $showingExitConfirmation,
            titleVisibility: .visible
        ) {
            Button("Exit Quiz", role: .destructive) {
                coordinator.dismiss()
            }
            Button("Continue Quiz", role: .cancel) {}
        } message: {
            Text("Are you sure you want to exit? Your progress will be lost.")
        }
        .onAppear { viewModel.startTimerIfNeeded() }
        .onDisappear { viewModel.stopTimer() }
    }
}

// MARK: - Subviews
private extension QuizPlayView {
    var headerView: some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.md) {
            HStack(alignment: .firstTextBaseline) {
                Text(viewModel.quiz?.title ?? "") // TODO: Fix
                    .font(DesignBook.Font.headline())
                
                Spacer()
                
                Text("Score: \(viewModel.score)/\(viewModel.totalQuestions)")
                    .font(.subheadline)
                    .foregroundStyle(DesignBook.Color.Text.secondary)
            }
            
            if viewModel.shouldShowTimer {
                HStack {
                    Spacer()
                    Label("\(viewModel.remainingSeconds)s", systemImage: "timer")
                        .font(DesignBook.Font.subheadline())
                        .foregroundStyle(DesignBook.Color.Text.secondary)
                    Spacer()
                }
            }
            
            ProgressView(value: Double(viewModel.answeredCount), total: Double(viewModel.totalQuestions))
                .animation(.easeInOut(duration: DesignBook.Duration.normal), value: viewModel.answeredCount)
        }
    }
    
    @ViewBuilder
    var questionView: some View {
        if let text = viewModel.currentQuestion?.text {
            Text(text)
                .font(DesignBook.Font.title2())
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
                                .foregroundStyle(DesignBook.Color.Text.primary)
                            Spacer()
                        }
                        .padding(DesignBook.Spacing.lg)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.backgroundColor(for: choice))
                        .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.sm, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    .disabled(viewModel.hasAnsweredCurrent)
                }
            }
        }
    }
    
    var footerView: some View {
        VStack(spacing: DesignBook.Spacing.md) {
            if autoAdvanceEnabled && viewModel.hasAnsweredCurrent && !viewModel.isOnLastQuestion {
                HStack {
                    Spacer()
                    Text("Next question in 1.5s...")
                        .font(DesignBook.Font.caption())
                        .foregroundStyle(DesignBook.Color.Text.secondary)
                    Spacer()
                }
            }
            
            if !autoAdvanceEnabled || viewModel.isOnLastQuestion {
                Button(
                    action: {
                        withAnimation(.easeInOut(duration: DesignBook.Duration.normal)) {
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
        }
    }
    
    var completedView: some View {
        VStack(spacing: DesignBook.Spacing.lg) {
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

// MARK: - Preview
#Preview {
    QuizPlayView(quiz: .example)
}
 