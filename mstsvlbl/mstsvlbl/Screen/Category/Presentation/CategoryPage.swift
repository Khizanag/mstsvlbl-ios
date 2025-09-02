//
//  CategoryPage.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import SwiftUI

struct CategoryPage: View {
    let category: Category
    @Environment(\.dismiss) private var dismiss
    @State private var quizzes: [Quiz] = []
    @State private var isLoading = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: DesignBook.Spacing.xl) {
                categoryHeader
                    .padding(.top, DesignBook.Spacing.lg)
                quizzesSection
                    .padding(.horizontal, DesignBook.Spacing.lg)
            }
            
        }
        .background(DesignBook.Color.Background.primary)
        .task {
            await loadQuizzes()
        }
        .navigationTitle(category.displayName)
    }
}

// MARK: - Components
private extension CategoryPage {
    var categoryHeader: some View {
        CategoryHeaderView(category: category)
    }
    
    var quizzesSection: some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.lg) {
            sectionHeader
            
            if isLoading {
                loadingView
            } else if quizzes.isEmpty {
                emptyStateView
            } else {
                quizzesList
            }
        }
    }
    
    var sectionHeader: some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.xs) {
            Text("Quizzes")
                .font(DesignBook.Font.title2())
                .fontWeight(.bold)
                .foregroundStyle(DesignBook.Color.Text.primary)
            
            Text("\(quizzes.count) quiz\(quizzes.count == 1 ? "" : "zes") available")
                .font(DesignBook.Font.subheadline())
                .foregroundStyle(DesignBook.Color.Text.secondary)
        }
    }
    
    var loadingView: some View {
        VStack(spacing: DesignBook.Spacing.lg) {
            ProgressView()
                .scaleEffect(1.2)
                .tint(category.color)
            
            Text("Loading quizzes...")
                .font(DesignBook.Font.subheadline())
                .foregroundStyle(DesignBook.Color.Text.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
    }
    
    var emptyStateView: some View {
        VStack(spacing: DesignBook.Spacing.lg) {
            Image(systemName: category.icon)
                .font(.system(size: 48, weight: .light))
                .foregroundStyle(category.color.opacity(0.6))
            
            VStack(spacing: DesignBook.Spacing.xs) {
                Text("No quizzes yet")
                    .font(DesignBook.Font.title2())
                    .fontWeight(.semibold)
                    .foregroundStyle(DesignBook.Color.Text.primary)
                
                Text("We're working on adding more \(category.displayName.lowercased()) quizzes")
                    .font(DesignBook.Font.subheadline())
                    .foregroundStyle(DesignBook.Color.Text.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 200)
    }
    
    var quizzesList: some View {
        LazyVStack(spacing: DesignBook.Spacing.lg) {
            ForEach(quizzes) { quiz in
                QuizCardView(quiz: quiz)
                    .onTapGesture {
                        // Handle quiz selection
                        print("Selected quiz: \(quiz.title)")
                    }
            }
        }
    }
}

// MARK: - Data Loading
private extension CategoryPage {
    func loadQuizzes() async {
        isLoading = true
        
        // Simulate loading delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // TODO: Replace with actual data loading from repository
        // For now, we'll create some sample quizzes
        quizzes = createSampleQuizzes()
        
        isLoading = false
    }
    
    func createSampleQuizzes() -> [Quiz] {
        // Create sample quizzes based on the category
        let sampleTitles = getSampleTitles(for: category)
        
        return sampleTitles.enumerated().map { index, title in
            Quiz(
                title: title,
                description: "A comprehensive quiz about \(title.lowercased())",
                createdAt: nil,
                coverUrl: URL(string: "https://images.unsplash.com/photo-\(1500000000000 + index)?w=400&h=300&fit=crop&crop=center"),
                maxTimeSeconds: 300,
                category: category,
                questions: []
            )
        }
    }
    
    func getSampleTitles(for category: Category) -> [String] {
        switch category {
        case .science:
            return ["Chemistry Basics", "Physics Fundamentals", "Biology Essentials", "Astronomy 101", "Earth Science"]
        case .mathematics:
            return ["Algebra Basics", "Geometry Fundamentals", "Calculus Introduction", "Statistics 101", "Trigonometry"]
        case .geography:
            return ["World Capitals", "Country Flags", "Mountain Ranges", "Oceans & Seas", "Climate Zones"]
        case .history:
            return ["Ancient Civilizations", "World Wars", "Renaissance Period", "Industrial Revolution", "Modern History"]
        case .literature:
            return ["Classic Novels", "Poetry Analysis", "Shakespeare Works", "Modern Literature", "Literary Devices"]
        case .sports:
            return ["Football Rules", "Basketball Basics", "Olympic Sports", "Tennis Fundamentals", "Athletics"]
        case .entertainment:
            return ["Movie Trivia", "Music History", "TV Shows", "Celebrity Facts", "Pop Culture"]
        case .technology:
            return ["Programming Basics", "Computer Hardware", "Internet History", "Mobile Apps", "AI & Machine Learning"]
        case .art:
            return ["Famous Paintings", "Art Movements", "Artists & Their Works", "Sculpture History", "Modern Art"]
        case .music:
            return ["Classical Music", "Jazz History", "Rock & Roll", "Music Theory", "Famous Composers"]
        case .food:
            return ["Cooking Basics", "World Cuisines", "Food History", "Nutrition Facts", "Culinary Arts"]
        case .travel:
            return ["World Destinations", "Travel Tips", "Cultural Etiquette", "Landmarks", "Adventure Travel"]
        case .business:
            return ["Business Fundamentals", "Marketing Basics", "Economics 101", "Entrepreneurship", "Management"]
        case .health:
            return ["Human Anatomy", "Nutrition Basics", "Exercise Science", "Mental Health", "Medical History"]
        case .nature:
            return ["Wildlife Facts", "Plant Biology", "Ecosystems", "Conservation", "Natural Phenomena"]
        case .space:
            return ["Solar System", "Space Exploration", "Astronomy Basics", "Galaxies", "Space Missions"]
        case .politics:
            return ["Government Systems", "Political History", "International Relations", "Democracy", "Political Theory"]
        case .fashion:
            return ["Fashion History", "Design Principles", "Fashion Trends", "Famous Designers", "Style Evolution"]
        case .automotive:
            return ["Car History", "Engine Basics", "Famous Cars", "Racing History", "Automotive Technology"]
        case .gaming:
            return ["Video Game History", "Gaming Genres", "Famous Games", "Gaming Technology", "Esports"]
        }
    }
}

// MARK: - Preview
#Preview {
    CategoryPage(category: .science)
}
