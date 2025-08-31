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
        VStack(alignment: .leading, spacing: DesignBook.Spacing.sm) {
            titleLabel
            
            countLabel
        }
        .padding(DesignBook.Spacing.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous)
                .fill(.thickMaterial)
        )
        .contentShape(Rectangle())
        .overlay(
            RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous)
                .stroke(DesignBook.Color.Border.default)
        )
        .shadow(.s)
    }
}

// MARK: - Components
private extension QuizCardView {
    var titleLabel: some View {
        Text(quiz.title)
            .font(DesignBook.Font.headline())
            .foregroundStyle(DesignBook.Color.Text.primary)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
    
    var countLabel: some View {
        Text("\(quiz.questions.count) questions")
            .font(DesignBook.Font.subheadline())
            .foregroundStyle(DesignBook.Color.Text.secondary)
    }
}

// MARK: - Preview
#Preview {
    QuizCardView(quiz: .example)
        .padding()
}
