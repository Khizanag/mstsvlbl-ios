//
//  CategoryHeaderView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct CategoryHeaderView: View {
    let category: Category
    let onTap: (() -> Void)?
    
    init(category: Category, onTap: (() -> Void)? = nil) {
        self.category = category
        self.onTap = onTap
    }
    
    var body: some View {
        if let onTap {
            Button(action: onTap){
                buttonLabel
            }
        } else {
            buttonLabel
        }
    }
}

// MARK: - Components
private extension CategoryHeaderView {
    var buttonLabel: some View {
        ZStack {
            backgroundGradient
            content
        }
        .shadow(.l)
    }
    
    var backgroundGradient: some View {
        RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [
                        category.color.opacity(0.2),
                        category.color.opacity(0.08),
                        DesignBook.Color.Background.primary
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [
                                category.color.opacity(0.32),
                                category.color.opacity(0.16)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.5
                    )
            )
    }
    
    var content: some View {
        HStack(spacing: DesignBook.Spacing.lg) {
            categoryIcon
            textContent
            Spacer()
            if onTap != nil {
                chevronButton
            }
        }
        .padding(.horizontal, DesignBook.Spacing.xl)
        .padding(.vertical, DesignBook.Spacing.lg)
    }
    
    var textContent: some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.sm) {
            titleText
            descriptionText
        }
    }
    
    var titleText: some View {
        Text(category.displayName)
            .font(DesignBook.Font.title2())
            .fontWeight(.bold)
            .foregroundStyle(
                LinearGradient(
                    colors: [category.color, category.color.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
    
    var descriptionText: some View {
        Text(category.description)
            .font(DesignBook.Font.subheadline())
            .foregroundStyle(DesignBook.Color.Text.secondary)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
    
    var chevronButton: some View {
        Image(systemName: "chevron.right.circle.fill")
            .font(.system(size: 24, weight: .medium))
            .foregroundStyle(
                LinearGradient(
                    colors: [category.color, category.color.opacity(0.7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .background(
                Circle()
                    .fill(DesignBook.Color.Background.primary)
                    .frame(width: 20, height: 20)
            )
    }
    
    var categoryIcon: some View {
        ZStack {
            outerGlow
            mainIconBackground
            iconImage
        }
    }
    
    var outerGlow: some View {
        Circle()
            .fill(category.color.opacity(0.2))
            .frame(width: 56, height: 56)
            .blur(radius: 8)
    }
    
    var mainIconBackground: some View {
        Circle()
            .fill(
                LinearGradient(
                    colors: [
                        category.color.opacity(0.15),
                        category.color.opacity(0.08)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: 52, height: 52)
            .overlay(
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [
                                category.color.opacity(0.4),
                                category.color.opacity(0.2)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.5
                    )
            )
    }
    
    var iconImage: some View {
        Image(systemName: category.icon)
            .font(.system(size: 24, weight: .semibold))
            .foregroundStyle(
                LinearGradient(
                    colors: [category.color, category.color.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: DesignBook.Spacing.lg) {
        CategoryHeaderView(category: .science)
        CategoryHeaderView(category: .geography)
        CategoryHeaderView(category: .technology)
    }
    .padding()
    .background(DesignBook.Color.Background.primary)
}
   
