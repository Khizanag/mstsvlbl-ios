//
//  DeepLinkNavigationCoordinator.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import SwiftUI
import Foundation

// MARK: - Deep Link Navigation Coordinator
@MainActor
public final class DeepLinkNavigationCoordinator: ObservableObject {
    
    @Published public var navigationPath = NavigationPath()
    @Published public var selectedTab: Int = 0 // Use index instead of Page enum
    @Published public var shouldNavigate = false
    @Published public var deepLinkDestination: DeepLinkDestination?
    
    // MARK: - Deep Link Specific Properties
    @Published public var quizToNavigate: Quiz?
    @Published public var shouldNavigateToQuiz = false
    @Published public var quizId: String?
    
    public init() {}
    
    public func navigate(to destination: DeepLinkDestination) {
        self.deepLinkDestination = destination
        self.shouldNavigate = true
        
        // Handle navigation based on destination
        switch destination {
        case .quiz(let id, let action):
            handleQuizNavigation(id: id, action: action)
            
        case .category(let name):
            handleCategoryNavigation(name: name)
            
        case .profile(let action):
            handleProfileNavigation(action: action)
            
        case .settings(let section):
            handleSettingsNavigation(section: section)
            
        case .discover(let filter, let sort):
            handleDiscoverNavigation(filter: filter, sort: sort)
            
        case .bookmarks(let filter):
            handleBookmarksNavigation(filter: filter)
            
        case .stats(let period):
            handleStatsNavigation(period: period)
            
        case .custom(let path, let parameters):
            handleCustomNavigation(path: path, parameters: parameters)
        }
    }
    
    // MARK: - Navigation Handlers
    private func handleQuizNavigation(id: String, action: String) {
        selectedTab = 1 // Quiz tab index
        
        // Set the quiz ID and trigger navigation
        quizId = id
        shouldNavigateToQuiz = true
        
        print("🎯 Deep link: Navigating to quiz with ID: \(id), action: \(action)")
    }
    
    private func handleCategoryNavigation(name: String) {
        selectedTab = 0 // Discover tab index
        // Navigate to category view
    }
    
    private func handleProfileNavigation(action: String) {
        selectedTab = 4 // Profile tab index
        // Handle profile-specific actions
    }
    
    private func handleSettingsNavigation(section: String) {
        selectedTab = 5 // Settings tab index
        // Navigate to specific settings section
    }
    
    private func handleDiscoverNavigation(filter: String?, sort: String?) {
        selectedTab = 0 // Discover tab index
        // Apply filters and sorting
    }
    
    private func handleBookmarksNavigation(filter: String?) {
        selectedTab = 2 // Bookmarks tab index
        // Apply bookmark filters
    }
    
    private func handleStatsNavigation(period: String) {
        selectedTab = 3 // Stats tab index
        // Set stats period
    }
    
    private func handleCustomNavigation(path: String, parameters: [String: Any]) {
        // Handle custom navigation paths
        print("🎯 Custom navigation: \(path) with parameters: \(parameters)")
    }
}
