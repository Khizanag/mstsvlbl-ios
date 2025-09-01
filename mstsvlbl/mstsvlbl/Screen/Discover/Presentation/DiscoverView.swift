//
//  DiscoverView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct DiscoverView: View {
    @Environment(Coordinator.self) private var coordinator
    @State private var viewModel = DiscoverViewModel()

    var body: some View {
        content
            .navigationTitle("Discover")
            .task { [self] in await viewModel.loadQuizzesIfNeeded() }
    }
}

// MARK: - Components
private extension DiscoverView {
    @ViewBuilder
    var content: some View {
        if viewModel.isLoading {
            loadingStateView
        } else if viewModel.discoverQuizzes.isEmpty {
            emptyStateView
        } else {
            loadedStateView
        }
    }

    var header: some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.sm) {
            Text("Featured Quizzes")
                .font(DesignBook.Font.title2())
            Text("Handpicked collections to get you started.")
                .font(DesignBook.Font.subheadline())
                .foregroundStyle(DesignBook.Color.Text.secondary)
        }
    }

    var banners: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DesignBook.Spacing.lg) {
                ForEach(viewModel.discoverQuizzes) { quiz in
                    DiscoverQuizCardView(quiz: quiz) { [self] in
                        coordinator.fullScreenCover(.overview(quiz))
                    }
                }
            }
            .padding(.horizontal, DesignBook.Spacing.lg)
            .padding(.vertical, DesignBook.Spacing.xs)
        }
    }
    
    var loadingStateView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    var emptyStateView: some View {
        VStack(spacing: DesignBook.Spacing.lg) {
            HeaderView(
                icon: "sparkles",
                title: "No recommendations right now",
                subtitle: "Check back soon for new featured quizzes"
            )
            .padding(.bottom, DesignBook.Spacing.lg)

            Spacer()
        }
        .padding(DesignBook.Spacing.xl)
    }
    
    var loadedStateView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignBook.Spacing.lg) {
                header
                banners
                    .padding(.horizontal, -DesignBook.Spacing.lg)
                Spacer(minLength: 0)
            }
            .padding(DesignBook.Spacing.lg)
        }
    }
}

// MARK: - Preview
#Preview {
    DiscoverView()
}
