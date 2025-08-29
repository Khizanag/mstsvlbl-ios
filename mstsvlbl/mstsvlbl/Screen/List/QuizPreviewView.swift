//
//  QuizPreviewView.swift
//  mstsvlbl
//
//  Created by Assistant on 29.08.25.
//

import SwiftUI

struct QuizPreviewView: View {
    let quiz: Quiz

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text(quiz.title)
                    .font(.title2).bold()

                HStack(spacing: 12) {
                    Label("\(quiz.questions.count) questions", systemImage: "list.number")
                    if let first = quiz.questions.first {
                        Label("First: \(first.text)", systemImage: "questionmark.circle")
                            .lineLimit(1)
                    }
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()

                VStack(alignment: .leading, spacing: 12) {
                    Text("Preview questions")
                        .font(.headline)
                    ForEach(quiz.questions.prefix(3)) { q in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(q.text)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                            Text("\(q.choices.count) options")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(12)
                        .background(Color.gray.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    if quiz.questions.count > 3 {
                        Text("…and more")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
            }
            .padding(16)
            .navigationTitle("Preview")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    @Environment(\.dismiss) private var dismiss
}

#Preview {
    QuizPreviewView(quiz: Quiz(title: "Sample", questions: []))
}


