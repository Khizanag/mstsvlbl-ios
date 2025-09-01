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
        } else if viewModel.categoryGroups.isEmpty {
            emptyStateView
        } else {
            loadedStateView
        }
    }

    var header: some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.sm) {
            Text("Explore curated collections organized by your interests")
                .font(DesignBook.Font.subheadline())
                .foregroundStyle(DesignBook.Color.Text.secondary)
        }
        .padding(.horizontal, DesignBook.Spacing.lg)
    }

    var categorySections: some View {
        LazyVStack(spacing: DesignBook.Spacing.xl) {
            ForEach(viewModel.categoryGroups) { categoryGroup in
                CategorySectionView(categoryGroup: categoryGroup) { quiz in
                    coordinator.fullScreenCover(.overview(quiz))
                }
            }
        }
    }
    
    var loadingStateView: some View {
        VStack(spacing: DesignBook.Spacing.lg) {
            ProgressView()
                .scaleEffect(1.2)
            
            Text("Discovering amazing quizzes...")
                .font(DesignBook.Font.subheadline())
                .foregroundStyle(DesignBook.Color.Text.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    var emptyStateView: some View {
        VStack(spacing: DesignBook.Spacing.lg) {
            HeaderView(
                icon: "sparkles",
                title: "No categories available",
                subtitle: "Check back soon for new organized collections"
            )
            .padding(.bottom, DesignBook.Spacing.lg)

            Spacer()
        }
        .padding(DesignBook.Spacing.xl)
    }
    
    var loadedStateView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignBook.Spacing.xl) {
                header
                categorySections
                Spacer(minLength: DesignBook.Spacing.xl)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    DiscoverView()
}
