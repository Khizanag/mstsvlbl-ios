//
//  QuizPreviewView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct QuizPreviewView: View {
    @Environment(\.dismiss) private var dismiss
    
    let quiz: Quiz
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.xl) {
            Text(quiz.title)
                .font(DesignBook.Font.title2)
                .bold()
            
            HStack(spacing: 12) {
                Label("\(quiz.questions.count) questions", systemImage: "list.number")
                
                if let first = quiz.questions.first {
                    Label("First: \(first.text)", systemImage: "questionmark.circle")
                        .lineLimit(1)
                }
            }
            .font(DesignBook.Font.subheadline)
            .foregroundStyle(DesignBook.Color.textSecondary)
            
            Divider()
            
            VStack(alignment: .leading, spacing: DesignBook.Spacing.lg) {
                Text("Preview questions")
                    .font(DesignBook.Font.headline)
                
                ForEach(quiz.questions.prefix(3)) { question in
                    makeQuestionItemView(question: question)
                }
                
                moreLabel
            }
            Spacer()
        }
        .padding(DesignBook.Layout.contentPadding)
        .navigationTitle("Preview")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") { dismiss() }
            }
        }
    }
}

// MARK: - Components
private extension QuizPreviewView {
    @ViewBuilder
    var moreLabel: some View {
        if quiz.questions.count > 3 {
            Text("…and more")
                .font(DesignBook.Font.caption)
                .foregroundStyle(DesignBook.Color.textSecondary)
        }
    }
    
    func makeQuestionItemView(question: Question) -> some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.sm) {
            Text(question.text)
                .font(DesignBook.Font.subheadline)
                .foregroundStyle(DesignBook.Color.textPrimary)
            
            Text("\(question.choices.count) options")
                .font(DesignBook.Font.caption)
                .foregroundStyle(DesignBook.Color.textSecondary)
        }
        .padding(DesignBook.Spacing.md)
        .background(DesignBook.Color.mutedBackground)
        .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.md, style: .continuous))
    }
}

#Preview {
    QuizPreviewView(
        quiz: Quiz(
            title: "Sample",
            description: "Description",
            createdAt: "bla",
            coverName: "coverName",
            questions: []
        )
    )
}
