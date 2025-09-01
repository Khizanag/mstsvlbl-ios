//
//  DiscoverQuizCardView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 01.09.25.
//

import SwiftUI

struct DiscoverQuizCardView: View {
    let quiz: Quiz
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottomLeading) {
                backgroundRectangle
                coverImage
                gradientOverlay
                contentInfo
            }
            .shadow(.l)
        }
    }
}

// MARK: - Private Extensions
private extension DiscoverQuizCardView {
    var cardWidth: CGFloat { 320 }
    var cardHeight: CGFloat { 180 }
    var cardShape: some Shape {
        RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous)
    }
    
    var backgroundRectangle: some View {
        cardShape
            .fill(DesignBook.Color.Background.muted)
            .frame(width: cardWidth, height: cardHeight)
    }
    
    var coverImage: some View {
        AsyncImage(url: quiz.coverUrl) { phase in
            switch phase {
            case .empty:
                RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous)
                    .fill(DesignBook.Color.Background.muted)
                    .overlay(
                        VStack {
                            ProgressView()
                                .scaleEffect(0.8)
                            Text("Loading...")
                                .font(.caption)
                                .foregroundStyle(DesignBook.Color.Text.secondary)
                        }
                    )
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
            case .failure(_):
                noCoverImage
            @unknown default:
                noCoverImage
            }
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipShape(cardShape)
    }
    
    var gradientOverlay: some View {
        LinearGradient(
            colors: [
                .black.opacity(0.1),
                .black.opacity(0.8)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .clipShape(cardShape)
    }
    
    var contentInfo: some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.sm) {
            if let category = quiz.category {
                categoryBadge(category)
            }
            
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
    
    @ViewBuilder
    private func categoryBadge(_ category: Category) -> some View {
        HStack(spacing: DesignBook.Spacing.xs) {
            Image(systemName: category.icon)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(category.color)
            
            Text(category.displayName)
                .font(DesignBook.Font.caption())
                .foregroundStyle(category.color)
        }
        .padding(.horizontal, DesignBook.Spacing.sm)
        .padding(.vertical, DesignBook.Spacing.xs)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: DesignBook.Radius.sm, style: .continuous))
    }
    
    var noCoverImage: some View {
        cardShape
            .fill(
                LinearGradient(
                    colors: [
                        DesignBook.Color.Background.muted,
                        DesignBook.Color.Background.muted.opacity(0.7)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: cardWidth, height: cardHeight)
    }
}

// MARK: - Preview
#Preview {
    DiscoverQuizCardView(quiz: .example) {
        print("Quiz tapped")
    }
    .padding()
}
