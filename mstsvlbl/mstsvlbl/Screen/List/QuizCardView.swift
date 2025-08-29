//
//  QuizCardView.swift
//  mstsvlbl
//
//  Created by Assistant on 29.08.25.
//

import SwiftUI

struct QuizCardView: View {
    let quiz: Quiz

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(quiz.title)
                .font(.headline)
                .foregroundStyle(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Text("\(quiz.questions.count) questions")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.thinMaterial)
        )
        .contentShape(Rectangle())
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray.opacity(0.15))
        )
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    QuizCardView(quiz: Quiz(title: "Sample", questions: []))
        .padding()
}


