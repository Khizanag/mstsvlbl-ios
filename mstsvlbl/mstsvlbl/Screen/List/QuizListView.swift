//
//  QuizListView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct QuizListView: View {
    @State private var viewModel = QuizListViewModel()
    @Environment(Coordinator.self) private var coordinator
    @Injected private var userStore: UserStore
    @Environment(\.deepLinkNavigationCoordinator) private var navigationCoordinator
    
    private let columns = [
        GridItem(
            .adaptive(
                minimum: 150,
                maximum: .infinity
            ),
            spacing: DesignBook.Spacing.lg,
            alignment: .top
        )
    ]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: DesignBook.Spacing.lg) {
                ForEach(viewModel.quizzes) { quiz in
                    self.makeItemView(quiz: quiz)
                }
            }
            .padding(DesignBook.Spacing.lg)
        }
        .navigationTitle("Quizzes")
        .toolbar { toolbarContent }
        .task { [self] in await viewModel.load() }
        .onChange(of: navigationCoordinator?.shouldNavigateToQuiz) { oldValue, newValue in
            if newValue == true {
                handleDeepLinkQuizNavigation()
            }
        }
        .onChange(of: viewModel.quizzes) { oldValue, newValue in
            // Check if we have a pending deep link navigation after quizzes are loaded
            if let navigationCoordinator, navigationCoordinator.shouldNavigateToQuiz,
               !newValue.isEmpty {
                print("🎯 QuizListView: Processing pending deep link navigation after quizzes loaded")
                handleDeepLinkQuizNavigation()
            }
        }

    }
}

// MARK: - Components
private extension QuizListView {
    func makeItemView(quiz: Quiz) -> some View {
        Button { [self] in
            coordinator.fullScreenCover(.overview(quiz))
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
                    .font(DesignBook.Font.caption())
            }
            .controlSize(.small)
        }
    }
    
    func makeToolbarItemButton(
        sort: QuizListViewModel.SortOption
    ) -> some View {
        Button { [self] in
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
        Button { [self] in
            userStore.toggleBookmark(quizId: quiz.id)
        } label: {
            Label(
                userStore.user.bookmarks.contains(quiz.id) ? "Remove Bookmark" : "Add to Bookmarks",
                systemImage: userStore.user.bookmarks.contains(quiz.id) ? "bookmark.slash" : "bookmark"
            )
        }
    }
    
    // MARK: - Deep Link Navigation
    private func handleDeepLinkQuizNavigation() {
        guard let navigationCoordinator = navigationCoordinator,
              let quizId = navigationCoordinator.quizId else { return }
        
        print("🎯 QuizListView: Handling deep link navigation to quiz ID: '\(quizId)'")
        print("🎯 QuizListView: Current quizzes count: \(viewModel.quizzes.count)")
        print("🎯 QuizListView: Available quiz IDs: \(viewModel.quizzes.map { $0.id })")
        
        // If quizzes are not loaded yet, wait for them
        if viewModel.quizzes.isEmpty {
            print("🎯 Deep link: Waiting for quizzes to load before navigation to '\(quizId)'")
            return
        }
        
        // Find the quiz in the loaded quizzes
        if let quiz = viewModel.quizzes.first(where: { $0.id == quizId }) {
            print("🎯 Deep link: Found quiz '\(quiz.title)', navigating to overview")
            coordinator.fullScreenCover(.overview(quiz))
        } else {
            print("🎯 Deep link: Quiz '\(quizId)' not found in loaded quizzes, attempting to load from repository")
            // If quiz not found, try to load it from repository
            Task {
                await loadAndNavigateToQuiz(id: quizId)
            }
        }
        
        // Reset the navigation state
        navigationCoordinator.shouldNavigateToQuiz = false
        navigationCoordinator.quizId = nil
    }
    
    private func loadAndNavigateToQuiz(id: String) async {
        do {
            let repository = LocalQuizRepository()
            let quizzes = try await repository.get(by: Set([id]))
            let quiz = quizzes.first
            
            if let quiz = quiz {
                await MainActor.run {
                    print("🎯 Deep link: Successfully loaded quiz '\(quiz.title)' from repository, navigating to overview")
                    coordinator.fullScreenCover(.overview(quiz))
                }
            } else {
                print("❌ Deep link: Quiz with ID '\(id)' not found")
            }
        } catch {
            print("❌ Deep link: Failed to load quiz '\(id)': \(error.localizedDescription)")
        }
    }
}

// MARK: - Preview
#Preview {
    QuizListView()
        .environment(\.deepLinkNavigationCoordinator, DeepLinkNavigationCoordinator())
}
