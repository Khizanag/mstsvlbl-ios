//
//  DependencyGroup.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

// MARK: - Dependency Group Protocol
protocol DependencyGroup {
    func register(in container: DIContainer)
}

// MARK: - Dependency Group Manager
final class DependencyGroupManager {
    private let container: DIContainer
    private var registeredGroups: Set<String> = []
    
    init(container: DIContainer = .shared) {
        self.container = container
    }
    
    func register(_ group: DependencyGroup, name: String? = nil) {
        let groupName = name ?? String(describing: type(of: group))
        
        guard !registeredGroups.contains(groupName) else {
            print("⚠️ Dependency group '\(groupName)' is already registered")
            return
        }
        
        group.register(in: container)
        registeredGroups.insert(groupName)
        print("✅ Registered dependency group: \(groupName)")
    }
    
    func registerAll(_ groups: [DependencyGroup]) {
        groups.forEach { register($0) }
    }
    
    func isRegistered(_ groupName: String) -> Bool {
        registeredGroups.contains(groupName)
    }
    
    func reset() {
        registeredGroups.removeAll()
        container.reset()
    }
}

// MARK: - Feature-based Dependency Groups
struct CoreDependencyGroup: DependencyGroup {
    func register(in container: DIContainer) {
        // Core services
        container.registerSingleton(AuthService.self) {
            AuthService()
        }
        
        container.registerSingleton(UserStore.self) {
            UserStore()
        }
    }
}

struct DataDependencyGroup: DependencyGroup {
    func register(in container: DIContainer) {
        // Data layer
        container.register(QuizRepository.self) {
            LocalQuizRepository()
        }
        
        container.register(GetDiscoverQuizzesUseCase.self) {
            DefaultGetDiscoverQuizzesUseCase()
        }
    }
}

struct UseCaseDependencyGroup: DependencyGroup {
    func register(in container: DIContainer) {
        // Use cases
        container.register(GetBookmarkedQuizzesUseCase.self) {
            DefaultGetBookmarkedQuizzesUseCase()
        }
    }
}

struct ViewModelDependencyGroup: DependencyGroup {
    func register(in container: DIContainer) {
        // ViewModels
        container.register(BookmarksViewModel.self) {
            BookmarksViewModel()
        }
        
        container.register(QuizListViewModel.self) {
            QuizListViewModel()
        }
        
        container.register(QuizViewModel.self) {
            QuizViewModel()
        }
    }
}

// MARK: - Convenience Extensions
extension DIContainer {
    static let groupManager = DependencyGroupManager()
    
    static func registerCoreDependencies() {
        groupManager.register(CoreDependencyGroup())
        groupManager.register(DataDependencyGroup())
        groupManager.register(UseCaseDependencyGroup())
        groupManager.register(ViewModelDependencyGroup())
    }
    
    static func registerFeatureDependencies() {
        registerCoreDependencies()
        // Add feature-specific dependencies here
    }
}
