//
//  DIModule.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

// MARK: - Module Protocol
public protocol DIModule {
    var name: String { get }
    var dependencies: [String] { get }
    func register(in container: DIContainer)
}

// MARK: - Module Manager
public final class DIModuleManager {
    private let container: DIContainer
    private var registeredModules: Set<String> = []
    private var moduleDependencies: [String: Set<String>] = [:]
    
    public init(container: DIContainer = .shared) {
        self.container = container
    }
    
    public func register(_ module: DIModule) {
        guard !registeredModules.contains(module.name) else {
            print("⚠️ Module '\(module.name)' is already registered")
            return
        }
        
        // Check dependencies
        for dependency in module.dependencies {
            guard registeredModules.contains(dependency) else {
                print("❌ Module '\(module.name)' depends on '\(dependency)' which is not registered")
                return
            }
        }
        
        module.register(in: container)
        registeredModules.insert(module.name)
        moduleDependencies[module.name] = Set(module.dependencies)
        print("✅ Registered module: \(module.name)")
    }
    
    public func registerAll(_ modules: [DIModule]) {
        // Sort modules by dependencies
        let sortedModules = sortModulesByDependencies(modules)
        
        for module in sortedModules {
            register(module)
        }
    }
    
    public func isRegistered(_ moduleName: String) -> Bool {
        registeredModules.contains(moduleName)
    }
    
    public func getDependencies(for moduleName: String) -> Set<String> {
        moduleDependencies[moduleName] ?? []
    }
    
    public func reset() {
        registeredModules.removeAll()
        moduleDependencies.removeAll()
        container.reset()
    }
    
    // MARK: - Private Methods
    private func sortModulesByDependencies(_ modules: [DIModule]) -> [DIModule] {
        var result: [DIModule] = []
        var visited: Set<String> = []
        var visiting: Set<String> = []
        
        func visit(_ module: DIModule) {
            guard !visited.contains(module.name) else { return }
            guard !visiting.contains(module.name) else {
                fatalError("Circular dependency detected involving module: \(module.name)")
            }
            
            visiting.insert(module.name)
            
            for dependency in module.dependencies {
                if let dependentModule = modules.first(where: { $0.name == dependency }) {
                    visit(dependentModule)
                }
            }
            
            visiting.remove(module.name)
            visited.insert(module.name)
            result.append(module)
        }
        
        for module in modules {
            visit(module)
        }
        
        return result
    }
}

// MARK: - Feature Modules
public struct CoreModule: DIModule {
    public let name = "Core"
    public let dependencies: [String] = []
    
    public func register(in container: DIContainer) {
        container.registerSingleton(AuthService.self) {
            AuthService()
        }
        
        container.registerSingleton(UserStore.self) {
            UserStore()
        }
    }
}

public struct DataModule: DIModule {
    public let name = "Data"
    public let dependencies: [String] = ["Core"]
    
    public func register(in container: DIContainer) {
        container.register(QuizRepository.self) {
            BundleQuizRepository()
        }
        
        container.register(DiscoverQuizzesRepository.self) {
            RandomDiscoverQuizzesRepository()
        }
    }
}

public struct UseCaseModule: DIModule {
    public let name = "UseCase"
    public let dependencies: [String] = ["Data"]
    
    public func register(in container: DIContainer) {
        container.register(GetBookmarkedQuizzesUseCase.self) {
            let repository: QuizRepository = container.resolve(QuizRepository.self)
            return DefaultGetBookmarkedQuizzesUseCase(repository: repository)
        }
    }
}

public struct PresentationModule: DIModule {
    public let name = "Presentation"
    public let dependencies: [String] = ["UseCase", "Core"]
    
    public func register(in container: DIContainer) {
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
    public static let moduleManager = DIModuleManager()
    
    public static func registerAllModules() {
        let modules: [DIModule] = [
            CoreModule(),
            DataModule(),
            UseCaseModule(),
            PresentationModule()
        ]
        
        moduleManager.registerAll(modules)
    }
    
    public static func registerModule(_ module: DIModule) {
        moduleManager.register(module)
    }
    
    public static func registerModules(_ modules: [DIModule]) {
        moduleManager.registerAll(modules)
    }
}

// MARK: - Module Property Wrapper
@propertyWrapper
public struct ModuleInjected<T> {
    private let moduleName: String
    private let identifier: String
    private var value: T?
    
    public init(module: String, identifier: String = "") {
        self.moduleName = module
        self.identifier = identifier
    }
    
    public var wrappedValue: T {
        get {
            if let value = value {
                return value
            }
            
            guard DIContainer.moduleManager.isRegistered(moduleName) else {
                fatalError("Module '\(moduleName)' is not registered")
            }
            
            let resolved = DIContainer.shared.resolve(T.self, identifier: identifier)
            // Note: This won't persist the value in structs, but that's fine for DI
            return resolved
        }
        set {
            value = newValue
        }
    }
}
