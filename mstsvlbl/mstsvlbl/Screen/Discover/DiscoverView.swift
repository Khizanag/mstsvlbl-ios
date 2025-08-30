//
//  DiscoverView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct DiscoverView: View {
    @Environment(Coordinator.self) private var coordinator
    @State private var quizzes: [Quiz] = []
    @State private var isLoading = false
    private let repository: DiscoverQuizzesRepository = RandomDiscoverQuizzesRepository()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignBook.Spacing.lg) {
                header
                banners
                Spacer(minLength: 0)
            }
            .padding(16)
        }
        .navigationTitle("Discover")
        .task { await loadIfNeeded() }
    }
}

#if DEBUG
#Preview {
    DiscoverView()
}
#endif

private extension DiscoverView {
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
        if isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, alignment: .center)
        } else if quizzes.isEmpty {
            Text("No recommendations right now. Check back soon.")
                .font(DesignBook.Font.subheadline())
                .foregroundStyle(DesignBook.Color.Text.secondary)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DesignBook.Spacing.lg) {
                    ForEach(quizzes) { quiz in
                        banner(for: quiz)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
    
    func banner(for quiz: Quiz) -> some View {
        Button {
            coordinator.fullScreenCover(.overview(quiz))
        } label: {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous)
                    .fill(DesignBook.Color.Background.muted)
                    .frame(width: 320, height: 180)
                
                if let name = quiz.coverName, !name.isEmpty {
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
                .padding(16)
            }
            .shadow(.l)
        }
        .buttonStyle(.plain)
    }
    
    func loadIfNeeded() async {
        guard quizzes.isEmpty, !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            quizzes = try await repository.getDiscoverQuizzes(limit: 5)
        } catch {
            quizzes = []
        }
    }
}

