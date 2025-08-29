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
            .toolbar { toolbarContent }
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

// MARK: - Toolbar
private extension QuizListView {
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Menu {
                // Section: Default
                Button {
                    viewModel.selectedSort = .default
                } label: {
                    HStack {
                        if isSelected(.default) { Image(systemName: "checkmark") }
                        Text(viewModelText(for: .default))
                    }
                }

                Divider()

                // Section: Title
                Button {
                    viewModel.selectedSort = .alphabeticalAsc
                } label: {
                    HStack {
                        if isSelected(.alphabeticalAsc) { Image(systemName: "checkmark") }
                        Text(viewModelText(for: .alphabeticalAsc))
                    }
                }
                Button {
                    viewModel.selectedSort = .alphabeticalDesc
                } label: {
                    HStack {
                        if isSelected(.alphabeticalDesc) { Image(systemName: "checkmark") }
                        Text(viewModelText(for: .alphabeticalDesc))
                    }
                }

                Divider()

                // Section: Question Count
                Button {
                    viewModel.selectedSort = .questionCountAsc
                } label: {
                    HStack {
                        if isSelected(.questionCountAsc) { Image(systemName: "checkmark") }
                        Text(viewModelText(for: .questionCountAsc))
                    }
                }
                Button {
                    viewModel.selectedSort = .questionCountDesc
                } label: {
                    HStack {
                        if isSelected(.questionCountDesc) { Image(systemName: "checkmark") }
                        Text(viewModelText(for: .questionCountDesc))
                    }
                }
            } label: {
                Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
                    .font(DesignBook.Font.caption)
            }
            .controlSize(.small)
        }
    }
}

// MARK: - Helpers
private extension QuizListView {
    func viewModelText(for option: QuizListViewModel.SortOption) -> String {
        option.title
    }

    func isSelected(_ option: QuizListViewModel.SortOption) -> Bool {
        viewModel.selectedSort == option
    }
}


#Preview {
    QuizListView()
}
