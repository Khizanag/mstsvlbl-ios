//
//  QuizListView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct QuizListView: View {
    @State private var viewModel = QuizListViewModel()
    @Environment(QuizFlowCoordinator.self) private var coordinator
    @Environment(UserStore.self) private var userStore

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
            coordinator.present(.play(quiz))
        } label: {
            QuizCardView(quiz: quiz)
        }
        .buttonStyle(.plain)
        .contextMenu { itemContextMenu(quiz: quiz) }
    }
}

// MARK: - Toolbar
private extension QuizListView {
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Menu {
                makeToolbarItemButton(sort: .default)

                Divider()
                
                makeToolbarItemButton(sort: .alphabeticalAsc)
                makeToolbarItemButton(sort: .alphabeticalDesc)
                
                Divider()
                
                makeToolbarItemButton(sort: .questionCountAsc)
                makeToolbarItemButton(sort: .questionCountDesc)
            } label: {
                Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
                    .font(DesignBook.Font.caption)
            }
            .controlSize(.small)
        }
    }
    
    func makeToolbarItemButton(
        sort: QuizListViewModel.SortOption
    ) -> some View {
        Button {
            viewModel.selectedSort = sort
        } label: {
            HStack {
                if isSelected(sort) {
                    Image(systemName: "checkmark")
                }
                
                Text(viewModelText(for: sort))
            }
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

    @ViewBuilder
    func itemContextMenu(quiz: Quiz) -> some View {
        Button {
            userStore.toggleBookmark(quizId: quiz.id)
        } label: {
            Label(userStore.user.bookmarks.contains(quiz.id) ? "Remove Bookmark" : "Add to Bookmarks",
                  systemImage: userStore.user.bookmarks.contains(quiz.id) ? "bookmark.slash" : "bookmark")
        }

        Button {
//            coordinator.present(quiz)
        } label: {
            Label("Preview", systemImage: "eye")
        }
    }
}


#Preview {
    QuizListView()
}
