//
//  Category.swift
//  mstsvlbl
//
//  Created by Assistant on 2024-12-19.
//

import SwiftUI

public enum Category: String, CaseIterable, Codable {
    case art = "art"
    case automotive = "automotive"
    case business = "business"
    case entertainment = "entertainment"
    case fashion = "fashion"
    case food = "food"
    case gaming = "gaming"
    case geography = "geography"
    case health = "health"
    case history = "history"
    case literature = "literature"
    case mathematics = "mathematics"
    case music = "music"
    case nature = "nature"
    case politics = "politics"
    case science = "science"
    case space = "space"
    case sports = "sports"
    case technology = "technology"
    case travel = "travel"
}

// MARK: - Computed Properties
extension Category {
    var displayName: String {
        switch self {
        case .art: "Art"
        case .automotive: "Automotive"
        case .business: "Business"
        case .entertainment: "Entertainment"
        case .fashion: "Fashion"
        case .food: "Food"
        case .gaming: "Gaming"
        case .geography: "Geography"
        case .health: "Health"
        case .history: "History"
        case .literature: "Literature"
        case .mathematics: "Mathematics"
        case .music: "Music"
        case .nature: "Nature"
        case .politics: "Politics"
        case .science: "Science"
        case .space: "Space"
        case .sports: "Sports"
        case .technology: "Technology"
        case .travel: "Travel"
        }
    }
    
    var color: Color {
        switch self {
        case .art: DesignBook.Color.Category.art
        case .automotive: DesignBook.Color.Category.automotive
        case .business: DesignBook.Color.Category.business
        case .entertainment: DesignBook.Color.Category.entertainment
        case .fashion: DesignBook.Color.Category.fashion
        case .food: DesignBook.Color.Category.food
        case .gaming: DesignBook.Color.Category.gaming
        case .geography: DesignBook.Color.Category.geography
        case .health: DesignBook.Color.Category.health
        case .history: DesignBook.Color.Category.history
        case .literature: DesignBook.Color.Category.literature
        case .mathematics: DesignBook.Color.Category.mathematics
        case .music: DesignBook.Color.Category.music
        case .nature: DesignBook.Color.Category.nature
        case .politics: DesignBook.Color.Category.politics
        case .science: DesignBook.Color.Category.science
        case .space: DesignBook.Color.Category.space
        case .sports: DesignBook.Color.Category.sports
        case .technology: DesignBook.Color.Category.technology
        case .travel: DesignBook.Color.Category.travel
        }
    }
    
    var icon: String {
        switch self {
        case .art: "paintbrush"
        case .automotive: "car"
        case .business: "briefcase"
        case .entertainment: "tv"
        case .fashion: "tshirt"
        case .food: "fork.knife"
        case .gaming: "gamecontroller"
        case .geography: "globe"
        case .health: "heart"
        case .history: "book.closed"
        case .literature: "text.book.closed"
        case .mathematics: "function"
        case .music: "music.note"
        case .nature: "leaf"
        case .politics: "building.columns"
        case .science: "atom"
        case .space: "star"
        case .sports: "sportscourt"
        case .technology: "laptopcomputer"
        case .travel: "airplane"
        }
    }
    
    var description: String {
        switch self {
        case .art: "Appreciate creativity and artistic expression"
        case .automotive: "Drive through automotive history"
        case .business: "Navigate the world of commerce"
        case .entertainment: "Discover the world of media and culture"
        case .fashion: "Style your knowledge of trends"
        case .food: "Savor the flavors of culinary arts"
        case .gaming: "Level up your gaming expertise"
        case .geography: "Journey around the world's landscapes"
        case .health: "Learn about wellness and medicine"
        case .history: "Travel through time and historical events"
        case .literature: "Dive into the world of stories and words"
        case .mathematics: "Challenge your mathematical thinking"
        case .music: "Harmonize with musical knowledge"
        case .nature: "Connect with the natural world"
        case .politics: "Understand governance and society"
        case .science: "Explore the wonders of scientific discovery"
        case .space: "Reach for the stars and beyond"
        case .sports: "Test your knowledge of athletic achievements"
        case .technology: "Explore the latest in tech innovation"
        case .travel: "Adventure through destinations and cultures"
        }
    }
}
