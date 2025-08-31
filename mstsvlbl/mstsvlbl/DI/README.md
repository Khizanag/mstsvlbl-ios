# Dependency Injection System

A comprehensive, feature-rich dependency injection system for SwiftUI applications following Clean Architecture principles.

## Features

- ✅ **Multiple Lifecycles**: Singleton, Transient, Weak
- ✅ **Property Wrappers**: `@Injected`, `@OptionalInjected`, `@LazyInjected`
- ✅ **Scoped DI**: App, Feature, View, Session scopes
- ✅ **Module System**: Organized by feature modules with dependency management
- ✅ **Factory Pattern**: Support for parameterized factories
- ✅ **Dependency Groups**: Logical grouping of related dependencies
- ✅ **Circular Dependency Detection**: Automatic detection and prevention
- ✅ **Testing Support**: Easy mocking and test setup
- ✅ **Thread Safe**: Safe for concurrent access

## Quick Start

### 1. Setup Dependencies

```swift
// In your App.swift or main setup
DIContainer.registerAllModules()
```

### 2. Use Property Wrappers

```swift
@Observable
final class MyViewModel {
    @Injected private var authService: AuthService
    @Injected private var repository: QuizRepository
    
    func doSomething() {
        authService.signInWithApple()
    }
}
```

### 3. Use in SwiftUI Views

```swift
struct MyView: View {
    @State private var viewModel = MyViewModel()
    
    var body: some View {
        // Your view content
    }
}
```

## Core Components

### DIContainer

The main container for managing dependencies.

```swift
let container = DIContainer.shared

// Register dependencies
container.registerSingleton(AuthService.self) { AuthService() }
container.register(QuizRepository.self) { BundleQuizRepository() }

// Resolve dependencies
let authService: AuthService = container.resolve(AuthService.self)
```

### Property Wrappers

#### @Injected
Basic dependency injection.

```swift
@Injected private var service: AuthService
@Injected(identifier: "bundle") private var repository: QuizRepository
```

#### @OptionalInjected
Optional dependency injection (won't crash if not registered).

```swift
@OptionalInjected private var optionalService: AuthService?
```

#### @LazyInjected
Lazy dependency injection (resolved only when accessed).

```swift
@LazyInjected private var lazyService: AuthService
```

#### @ScopedInjected
Scoped dependency injection.

```swift
@ScopedInjected(scope: .feature) private var featureService: AuthService
```

#### @ModuleInjected
Module-based dependency injection.

```swift
@ModuleInjected(module: "Core") private var coreService: AuthService
```

## Lifecycles

### Singleton
Same instance every time.

```swift
container.registerSingleton(AuthService.self) { AuthService() }
```

### Transient
New instance every time.

```swift
container.register(TransientService.self) { TransientService() }
```

### Weak
Same instance until deallocated.

```swift
container.registerWeak(WeakService.self) { WeakService() }
```

## Scopes

### App Scope
Application-wide singleton.

```swift
container.scope(.app).registerSingleton(AuthService.self) { AuthService() }
```

### Feature Scope
Per-feature singleton.

```swift
container.scope(.feature).registerSingleton(FeatureService.self) { FeatureService() }
```

### View Scope
Per-view instance.

```swift
container.scope(.view).register(ViewModelFactory.self) { ViewModelFactory() }
```

### Session Scope
Per-session instance.

```swift
container.scope(.session).register(SessionService.self) { SessionService() }
```

## Modules

Organize dependencies by feature modules.

```swift
struct CoreModule: DIModule {
    let name = "Core"
    let dependencies: [String] = []
    
    func register(in container: DIContainer) {
        container.registerSingleton(AuthService.self) { AuthService() }
        container.registerSingleton(UserStore.self) { UserStore() }
    }
}

// Register modules
DIContainer.registerAllModules()
```

## Factory Pattern

### Basic Factory
```swift
container.registerFactory(QuizViewModel.self) { QuizViewModel() }
let viewModel: QuizViewModel = container.create(QuizViewModel.self)
```

### Parameterized Factory
```swift
container.registerParameterizedFactory(QuizViewModel.self) { (quiz: Quiz) in
    QuizViewModel(quiz: quiz)
}
let viewModel: QuizViewModel = container.create(QuizViewModel.self, with: quiz)
```

## Dependency Groups

Logical grouping of related dependencies.

```swift
struct CoreDependencyGroup: DependencyGroup {
    func register(in container: DIContainer) {
        container.registerSingleton(AuthService.self) { AuthService() }
        container.registerSingleton(UserStore.self) { UserStore() }
    }
}

// Register groups
DIContainer.groupManager.register(CoreDependencyGroup())
```

## Testing

### Mock Setup
```swift
func setupMockDI() {
    let container = DIContainer.shared
    
    container.register(QuizRepository.self, factory: { MockQuizRepository() }, identifier: "mock")
    container.register(AuthService.self, instance: MockAuthService())
}
```

### Test Usage
```swift
class TestViewModel {
    @Injected(identifier: "mock") private var repository: QuizRepository
    @Injected private var authService: AuthService
}
```

## Advanced Usage

### Custom Identifiers
```swift
container.register(QuizRepository.self, factory: { BundleQuizRepository() }, identifier: "bundle")
container.register(QuizRepository.self, factory: { NetworkQuizRepository() }, identifier: "network")

@Injected(identifier: "bundle") private var bundleRepo: QuizRepository
@Injected(identifier: "network") private var networkRepo: QuizRepository
```

### Circular Dependency Detection
The system automatically detects and prevents circular dependencies when using modules.

### Container Management
```swift
// Reset all dependencies
DIContainer.shared.reset()

// Remove specific dependency
DIContainer.shared.remove(AuthService.self)

// Reset specific scope
DIContainer.shared.resetScope(.feature)
```

## Best Practices

1. **Use Modules**: Organize dependencies by feature modules
2. **Prefer Property Wrappers**: Use `@Injected` for cleaner code
3. **Use Appropriate Lifecycles**: Choose the right lifecycle for your use case
4. **Use Scopes**: Use scopes to manage dependency lifecycles
5. **Test with Mocks**: Use identifiers to easily swap implementations for testing
6. **Register Early**: Register all dependencies at app startup
7. **Use Factories**: Use factories for complex object creation

## Migration Guide

### From Manual DI
```swift
// Before
class ViewModel {
    private let service: AuthService
    
    init(service: AuthService) {
        self.service = service
    }
}

// After
@Observable
final class ViewModel {
    @Injected private var service: AuthService
}
```

### From Other DI Libraries
The system is designed to be familiar to users of other DI libraries while providing additional features specific to SwiftUI and Clean Architecture.

## Performance

- **Lazy Resolution**: Dependencies are resolved only when accessed
- **Caching**: Singleton and weak instances are cached
- **Thread Safe**: Safe for concurrent access
- **Memory Efficient**: Weak references prevent memory leaks

## Troubleshooting

### Common Issues

1. **"No registration found"**: Make sure the dependency is registered before use
2. **Circular dependency**: Check module dependencies for circular references
3. **Memory leaks**: Use appropriate lifecycles (transient for short-lived objects)
4. **Thread issues**: All operations are thread-safe

### Debug Tips

- Enable logging to see registration and resolution
- Use `resolveOptional` for optional dependencies
- Check module dependencies for missing registrations
