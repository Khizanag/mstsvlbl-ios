//
//  QuizOverviewView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct QuizOverviewView: View {
    @Environment(Coordinator.self) private var coordinator
    
    let quiz: Quiz
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignBook.Spacing.lg) {
                cover
                
                detailsSection
                
                Spacer(minLength: DesignBook.Spacing.xl)
                
                actionButtons
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Overview")
    }
}

// MARK: - Components
private extension QuizOverviewView {
    var cover: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous)
                .fill(DesignBook.Color.Background.muted)
                .frame(height: 180)
            
            if let name = quiz.coverName, !name.isEmpty {
                Image(name)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous))
            } else {
                Image(systemName: "square.grid.2x2")
                    .font(.system(size: 48))
                    .foregroundStyle(DesignBook.Color.Text.secondary)
            }
        }
        .shadow(DesignBook.Shadow.m)
    }
    
    var actionButtons: some View {
        HStack(spacing: DesignBook.Spacing.lg) {
            Button {
                coordinator.push(.play(quiz))
            } label: {
                Label("Start", systemImage: "play.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            ShareLink(item: quiz.title) {
                Label("Share", systemImage: "square.and.arrow.up")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
    }
    
    var detailsSection: some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.sm) {
            Text(quiz.title)
                .font(DesignBook.Font.title2())
            
            if let description = quiz.description, !description.isEmpty {
                Text(description)
                    .font(DesignBook.Font.body())
                    .foregroundStyle(DesignBook.Color.Text.secondary)
            }
            
            HStack(spacing: DesignBook.Spacing.xl) {
                Label("\(quiz.questions.count) questions", systemImage: "list.number")
                if let createdAt = quiz.createdAt {
                    Label(createdAt, systemImage: "calendar")
                }
                if let max = quiz.maxTimeSeconds, max > 0 {
                    Label("\(max)s", systemImage: "timer")
                }
            }
            .font(DesignBook.Font.subheadline())
            .foregroundStyle(DesignBook.Color.Text.secondary)
        }
    }
}

// MARK: - Preview
#Preview {
    QuizOverviewView(quiz: .example)
}
 
