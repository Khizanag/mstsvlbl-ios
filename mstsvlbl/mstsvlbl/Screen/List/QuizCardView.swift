//
//  QuizCardView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct QuizCardView: View {
    let quiz: Quiz

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(quiz.title)
                .font(DesignBook.Font.headline)
                .foregroundStyle(DesignBook.Color.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Text("\(quiz.questions.count) questions")
                .font(DesignBook.Font.subheadline)
                .foregroundStyle(DesignBook.Color.textSecondary)
        }
        .padding(DesignBook.Layout.cardPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous)
                .fill(.thinMaterial)
        )
        .contentShape(Rectangle())
        .overlay(
            RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous)
                .stroke(DesignBook.Color.cardBorder)
        )
        .shadow(color: DesignBook.Color.surfaceShadow, radius: DesignBook.Shadow.cardRadius, x: 0, y: DesignBook.Shadow.cardOffsetY)
    }
}

#Preview {
    QuizCardView(quiz: Quiz(title: "Sample", questions: []))
        .padding()
}