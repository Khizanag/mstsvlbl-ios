//
//  QuizPreviewView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct QuizPreviewView: View {
    let quiz: Quiz

    var body: some View {
//        NavigationView {
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
                    ForEach(quiz.questions.prefix(3)) { q in
                        VStack(alignment: .leading, spacing: DesignBook.Spacing.sm) {
                            Text(q.text)
                                .font(DesignBook.Font.subheadline)
                                .foregroundStyle(DesignBook.Color.textPrimary)
                            Text("\(q.choices.count) options")
                                .font(DesignBook.Font.caption)
                                .foregroundStyle(DesignBook.Color.textSecondary)
                        }
                        .padding(DesignBook.Spacing.md)
                        .background(DesignBook.Color.mutedBackground)
                        .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.md, style: .continuous))
                    }
                    if quiz.questions.count > 3 {
                        Text("…and more")
                            .font(DesignBook.Font.caption)
                            .foregroundStyle(DesignBook.Color.textSecondary)
                    }
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
//        }
    }

    @Environment(\.dismiss) private var dismiss
}

#Preview {
    QuizPreviewView(quiz: Quiz(title: "Sample", questions: []))
}


