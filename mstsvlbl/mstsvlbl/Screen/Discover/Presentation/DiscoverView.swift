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
    @State private var selectedItemId: String?

    var body: some View {
        content
            .navigationTitle("Discover")
            .task { [self] in await viewModel.loadQuizzesIfNeeded() }
    }
}

private extension DiscoverView {
    @ViewBuilder
    var content: some View {
        if viewModel.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else if viewModel.discoverQuizzes.isEmpty {
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
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: DesignBook.Spacing.lg) {
                    header
                    banners
                    Spacer(minLength: 0)
                }
                .padding(DesignBook.Spacing.lg)
            }
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
    
    @ViewBuilder
    var banners: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DesignBook.Spacing.lg) {
                ForEach(viewModel.discoverQuizzes) { quiz in
                    self.banner(for: quiz)
                }
            }
            .padding(.horizontal, DesignBook.Spacing.lg)
            .padding(.vertical, DesignBook.Spacing.xs)
        }
    }
    
    func banner(for quiz: Quiz) -> some View {
        Button { [self] in
            coordinator.fullScreenCover(.overview(quiz))
        } label: {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous)
                    .fill(DesignBook.Color.Background.muted)
                    .frame(width: 320, height: 180)
                
                if let name = quiz.coverName {
                    Image(name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 320, height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous))
                }
                
                LinearGradient(
                    colors: [
                        .black.opacity(0.0),
                        .black.opacity(0.65)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous))
                
                VStack(alignment: .leading, spacing: DesignBook.Spacing.sm) {
                    Text(quiz.title)
                        .font(DesignBook.Font.title2())
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: DesignBook.Spacing.lg) {
                        Label("\(quiz.questions.count) questions", systemImage: "list.number")
                        if let max = quiz.maxTimeSeconds, max > 0 {
                            Label("\(max)s", systemImage: "timer")
                        }
                    }
                    .font(DesignBook.Font.footnote())
                    .foregroundStyle(.white.opacity(0.9))
                }
                .padding(DesignBook.Spacing.lg)
            }
            .shadow(.l)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    DiscoverView()
}
