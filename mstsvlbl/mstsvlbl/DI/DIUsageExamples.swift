//
//  DIUsageExamples.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation
import SwiftUI

// MARK: - Usage Examples

/*
 This file contains comprehensive examples of how to use the Dependency Injection system.
 It demonstrates all the features and patterns available.
 */

// MARK: - Basic Registration and Resolution
struct BasicDIExamples {
    
    static func setupBasicDI() {
        let container = DIContainer.shared
        
        // Register a singleton
        container.registerSingleton(AuthService.self) {
            AuthService()
        }
        
        // Register a transient dependency
        container.register(QuizRepository.self) {
            BundleQuizRepository()
        }
        
        // Register with identifier
        container.register(QuizRepository.self, factory: {
            BundleQuizRepository()
        }, identifier: "bundle")
        
        // Register an instance directly
        container.register(UserStore.self, instance: UserStore())
    }
    
    static func resolveDependencies() {
        let container = DIContainer.shared
        
        // Resolve dependencies
        let authService: AuthService = container.resolve(AuthService.self)
        let repository: QuizRepository = container.resolve(QuizRepository.self)
        
        // Resolve with identifier
        let bundleRepository: QuizRepository = container.resolve(QuizRepository.self, identifier: "bundle")
        
        // Resolve optional (won't crash if not registered)
        let optionalService: AuthService? = container.resolveOptional(AuthService.self)
    }
}

// MARK: - Property Wrapper Usage
struct PropertyWrapperExamples {
    
    // Basic injection
    @Injected private var authService: AuthService
    @Injected private var userStore: UserStore
    
    // Injection with identifier
    @Injected(identifier: "bundle") private var repository: QuizRepository
    
    // Optional injection
    @OptionalInjected private var optionalService: AuthService?
    
    // Lazy injection (resolved only when accessed)
    @LazyInjected private var lazyService: AuthService
    
    // Scoped injection
    @ScopedInjected(scope: .feature) private var featureService: AuthService
    
    // Module injection
    @ModuleInjected(module: "Core") private var coreService: AuthService
    
    func useInjectedDependencies() {
        // Use the injected dependencies
        authService.signInWithApple()
        userStore.saveUser(User.example)
        
        if let service = optionalService {
            service.signOut()
        }
    }
}

// MARK: - ViewModel with DI
@Observable
final class ExampleViewModel {
    @Injected private var authService: AuthService
    @Injected private var userStore: UserStore
    @Injected private var repository: QuizRepository
    
    private(set) var isLoading = false
    private(set) var quizzes: [Quiz] = []
    
    func loadQuizzes() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            quizzes = try await repository.getAll()
        } catch {
            print("Error loading quizzes: \(error)")
        }
    }
    
    func signIn() {
        authService.signInWithApple()
    }
}

// MARK: - SwiftUI View with DI
struct ExampleView: View {
    @State private var viewModel = ExampleViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(viewModel.quizzes) { quiz in
                    Text(quiz.title)
                }
            }
            
            Button("Sign In") {
                viewModel.signIn()
            }
        }
        .task {
            await viewModel.loadQuizzes()
        }
    }
}

// MARK: - Factory Pattern Usage
struct FactoryExamples {
    
    static func setupFactories() {
        let container = DIContainer.shared
        
        // Register a factory
        container.registerFactory(QuizViewModel.self) {
            QuizViewModel()
        }
        
        // Register a parameterized factory
        container.registerParameterizedFactory(QuizViewModel.self) { (quiz: Quiz) in
            QuizViewModel(quiz: quiz)
        }
    }
    
    static func useFactories() {
        let container = DIContainer.shared
        
        // Create using factory
        let viewModel: QuizViewModel = container.create(QuizViewModel.self)
        
        // Create using parameterized factory
        let quiz = Quiz.example
        let parameterizedViewModel: QuizViewModel = container.create(QuizViewModel.self, with: quiz)
    }
}

// MARK: - Scoped DI Usage
struct ScopedDIExamples {
    
    static func setupScopedDI() {
        let container = DIContainer.shared
        
        // App scope (singleton)
        container.scope(.app).registerSingleton(AuthService.self) {
            AuthService()
        }
        
        // Feature scope (per feature)
        container.scope(.feature).registerSingleton(FeatureService.self) {
            FeatureService()
        }
        
        // View scope (per view)
        container.scope(.view).register(ViewModelFactory.self) {
            ViewModelFactory()
        }
    }
    
    static func useScopedDI() {
        let container = DIContainer.shared
        
        // Resolve from app scope
        let authService: AuthService = container.scope(.app).resolve(AuthService.self)
        
        // Resolve from feature scope
        let featureService: FeatureService = container.scope(.feature).resolve(FeatureService.self)
        
        // Resolve from view scope
        let factory: ViewModelFactory = container.scope(.view).resolve(ViewModelFactory.self)
    }
}

// MARK: - Module Usage
struct ModuleExamples {
    
    static func setupModules() {
        // Register all modules at once
        DIContainer.registerAllModules()
        
        // Or register individual modules
        DIContainer.registerModule(CoreModule())
        DIContainer.registerModule(DataModule())
    }
    
    static func useModuleDI() {
        // Dependencies are automatically resolved based on module dependencies
        let authService: AuthService = DIContainer.shared.resolve(AuthService.self)
        let repository: QuizRepository = DIContainer.shared.resolve(QuizRepository.self)
    }
}

// MARK: - Dependency Groups Usage
struct DependencyGroupExamples {
    
    static func setupGroups() {
        let container = DIContainer.shared
        
        // Register dependency groups
        DIContainer.groupManager.register(CoreDependencyGroup())
        DIContainer.groupManager.register(DataDependencyGroup())
        DIContainer.groupManager.register(UseCaseDependencyGroup())
        DIContainer.groupManager.register(ViewModelDependencyGroup())
        
        // Or register all at once
        DIContainer.registerCoreDependencies()
    }
}

// MARK: - Advanced Usage Patterns
struct AdvancedDIExamples {
    
    static func setupAdvancedDI() {
        let container = DIContainer.shared
        
        // Register with different lifecycles
        container.registerSingleton(AuthService.self) { AuthService() }
        container.registerWeak(WeakService.self) { WeakService() }
        container.register(TransientService.self) { TransientService() }
        
        // Register with custom identifiers
        container.register(QuizRepository.self, factory: { BundleQuizRepository() }, identifier: "bundle")
        container.register(QuizRepository.self, factory: { NetworkQuizRepository() }, identifier: "network")
        
        // Register factories
        container.registerFactory(QuizViewModel.self) { QuizViewModel() }
        container.registerParameterizedFactory(QuizViewModel.self) { (quiz: Quiz) in QuizViewModel(quiz: quiz) }
    }
    
    static func demonstrateLifecycles() {
        let container = DIContainer.shared
        
        // Singleton - same instance every time
        let singleton1: AuthService = container.resolve(AuthService.self)
        let singleton2: AuthService = container.resolve(AuthService.self)
        print("Singleton same instance: \(singleton1 === singleton2)") // true
        
        // Transient - new instance every time
        let transient1: TransientService = container.resolve(TransientService.self)
        let transient2: TransientService = container.resolve(TransientService.self)
        print("Transient same instance: \(transient1 === transient2)") // false
        
        // Weak - same instance until deallocated
        let weak1: WeakService = container.resolve(WeakService.self)
        let weak2: WeakService = container.resolve(WeakService.self)
        print("Weak same instance: \(weak1 === weak2)") // true
    }
}

// MARK: - Mock Services for Testing
struct MockServices {
    
    static func setupMockDI() {
        let container = DIContainer.shared
        
        // Register mock implementations
        container.register(QuizRepository.self, factory: { MockQuizRepository() }, identifier: "mock")
        container.register(AuthService.self, instance: MockAuthService())
    }
}

// MARK: - Example Services
class FeatureService {
    func doSomething() {
        print("Feature service doing something")
    }
}

class ViewModelFactory {
    func createViewModel() -> ExampleViewModel {
        ExampleViewModel()
    }
}

class TransientService {
    let id = UUID()
}

class WeakService {
    let id = UUID()
}

class MockQuizRepository: QuizRepository {
    func getAll() async throws -> [Quiz] {
        return [Quiz.example]
    }
    
    func get(by ids: [String]) async throws -> [Quiz] {
        return [Quiz.example]
    }
}

class MockAuthService: AuthService {
    override func signInWithApple() {
        print("Mock sign in")
    }
}

// MARK: - App Setup Example
struct AppSetupExample {
    
    static func setupAppDependencies() {
        // Setup all dependencies for the app
        DIContainer.registerAllModules()
        
        // Or setup step by step
        DIContainer.groupManager.register(CoreDependencyGroup())
        DIContainer.groupManager.register(DataDependencyGroup())
        DIContainer.groupManager.register(UseCaseDependencyGroup())
        DIContainer.groupManager.register(ViewModelDependencyGroup())
        
        // Setup scoped dependencies
        DIContainer.scope(.app).registerSingleton(AuthService.self) { AuthService() }
        DIContainer.scope(.feature).registerSingleton(FeatureService.self) { FeatureService() }
        
        print("✅ All dependencies registered successfully")
    }
}
