//
//  CategorySectionView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import SwiftUI

struct CategorySectionView: View {
    let categoryGroup: CategoryGroup
    let onQuizTap: (Quiz) -> Void
    let onCategoryTap: (Category) -> Void
    
    var body: some View {
        VStack(spacing: DesignBook.Spacing.lg) {
            CategoryHeaderView(category: categoryGroup.category) {
                onCategoryTap(categoryGroup.category)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DesignBook.Spacing.md) {
                    ForEach(categoryGroup.quizzes) { quiz in
                        DiscoverQuizCardView(quiz: quiz) {
                            onQuizTap(quiz)
                        }
                    }
                }
                .padding(.horizontal, DesignBook.Spacing.lg)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let sampleQuizzes = [
        Quiz.example,
        Quiz.example,
        Quiz.example
    ]
    let categoryGroup = CategoryGroup(category: .science, quizzes: sampleQuizzes)
    
    CategorySectionView(
        categoryGroup: categoryGroup,
        onQuizTap: { quiz in
            print("Quiz tapped: \(quiz.title)")
        },
        onCategoryTap: { category in
            print("Category tapped: \(category.displayName)")
        }
    )
    .padding()
}
