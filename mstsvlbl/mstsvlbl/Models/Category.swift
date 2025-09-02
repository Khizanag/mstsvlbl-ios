//
//  Category.swift
//  mstsvlbl
//
//  Created by Assistant on 2024-12-19.
//

import SwiftUI

public enum Category: String, CaseIterable, Codable {
    case science = "science"
    case mathematics = "mathematics"
    case geography = "geography"
    case history = "history"
    case literature = "literature"
    case sports = "sports"
    case entertainment = "entertainment"
    case technology = "technology"
    case art = "art"
    case music = "music"
    case food = "food"
    case travel = "travel"
    case business = "business"
    case health = "health"
    case nature = "nature"
    case space = "space"
    case politics = "politics"
    case fashion = "fashion"
    case automotive = "automotive"
    case gaming = "gaming"
}

// MARK: - Computed Properties
extension Category {
    var displayName: String {
        switch self {
        case .science: "Science"
        case .mathematics: "Mathematics"
        case .geography: "Geography"
        case .history: "History"
        case .literature: "Literature"
        case .sports: "Sports"
        case .entertainment: "Entertainment"
        case .technology: "Technology"
        case .art: "Art"
        case .music: "Music"
        case .food: "Food"
        case .travel: "Travel"
        case .business: "Business"
        case .health: "Health"
        case .nature: "Nature"
        case .space: "Space"
        case .politics: "Politics"
        case .fashion: "Fashion"
        case .automotive: "Automotive"
        case .gaming: "Gaming"
        }
    }
    
    var color: Color {
        switch self {
        case .science: DesignBook.Color.Category.science
        case .mathematics: DesignBook.Color.Category.mathematics
        case .geography: DesignBook.Color.Category.geography
        case .history: DesignBook.Color.Category.history
        case .literature: DesignBook.Color.Category.literature
        case .sports: DesignBook.Color.Category.sports
        case .entertainment: DesignBook.Color.Category.entertainment
        case .technology: DesignBook.Color.Category.technology
        case .art: DesignBook.Color.Category.art
        case .music: DesignBook.Color.Category.music
        case .food: DesignBook.Color.Category.food
        case .travel: DesignBook.Color.Category.travel
        case .business: DesignBook.Color.Category.business
        case .health: DesignBook.Color.Category.health
        case .nature: DesignBook.Color.Category.nature
        case .space: DesignBook.Color.Category.space
        case .politics: DesignBook.Color.Category.politics
        case .fashion: DesignBook.Color.Category.fashion
        case .automotive: DesignBook.Color.Category.automotive
        case .gaming: DesignBook.Color.Category.gaming
        }
    }
    
    var icon: String {
        switch self {
        case .science: "atom"
        case .mathematics: "function"
        case .geography: "globe"
        case .history: "book.closed"
        case .literature: "text.book.closed"
        case .sports: "sportscourt"
        case .entertainment: "tv"
        case .technology: "laptopcomputer"
        case .art: "paintbrush"
        case .music: "music.note"
        case .food: "fork.knife"
        case .travel: "airplane"
        case .business: "briefcase"
        case .health: "heart"
        case .nature: "leaf"
        case .space: "star"
        case .politics: "building.columns"
        case .fashion: "tshirt"
        case .automotive: "car"
        case .gaming: "gamecontroller"
        }
    }
    
    var description: String {
        switch self {
        case .science: "Explore the wonders of scientific discovery"
        case .mathematics: "Challenge your mathematical thinking"
        case .geography: "Journey around the world's landscapes"
        case .history: "Travel through time and historical events"
        case .literature: "Dive into the world of stories and words"
        case .sports: "Test your knowledge of athletic achievements"
        case .entertainment: "Discover the world of media and culture"
        case .technology: "Explore the latest in tech innovation"
        case .art: "Appreciate creativity and artistic expression"
        case .music: "Harmonize with musical knowledge"
        case .food: "Savor the flavors of culinary arts"
        case .travel: "Adventure through destinations and cultures"
        case .business: "Navigate the world of commerce"
        case .health: "Learn about wellness and medicine"
        case .nature: "Connect with the natural world"
        case .space: "Reach for the stars and beyond"
        case .politics: "Understand governance and society"
        case .fashion: "Style your knowledge of trends"
        case .automotive: "Drive through automotive history"
        case .gaming: "Level up your gaming expertise"
        }
    }
}
