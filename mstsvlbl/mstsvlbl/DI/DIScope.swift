//
//  DIScope.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

// MARK: - Scope Types
enum DIScope: String, CaseIterable {
    case app = "app"
    case feature = "feature"
    case view = "view"
    case session = "session"
}

// MARK: - Scoped Container
final class ScopedDIContainer {
    private let parent: DIContainer
    private let scope: DIScope
    private var registrations: [String: Any] = [:]
    private var instances: [String: Any] = [:]
    
    init(parent: DIContainer, scope: DIScope) {
        self.parent = parent
        self.scope = scope
    }
    
    // MARK: - Registration
    func register<T>(
        _ type: T.Type,
        factory: @escaping () -> T,
        identifier: String = ""
    ) {
        let key = makeKey(for: type, identifier: identifier)
        let registration = DependencyRegistration(factory: factory, lifecycle: .transient, identifier: identifier)
        registrations[key] = registration
    }
    
    func registerSingleton<T>(
        _ type: T.Type,
        factory: @escaping () -> T,
        identifier: String = ""
    ) {
        let key = makeKey(for: type, identifier: identifier)
        let registration = DependencyRegistration(factory: factory, lifecycle: .singleton, identifier: identifier)
        registrations[key] = registration
    }
    
    // MARK: - Resolution
    func resolve<T>(_ type: T.Type, identifier: String = "") -> T {
        let key = makeKey(for: type, identifier: identifier)
        
        // Check if we have an instance in this scope
        if let instance = instances[key] as? T {
            return instance
        }
        
        // Check if we have a registration in this scope
        if let registration = registrations[key] as? DependencyRegistration<T> {
            let instance = registration.factory()
            
            if registration.lifecycle == .singleton {
                instances[key] = instance
            }
            
            return instance
        }
        
        // Fall back to parent container
        return parent.resolve(type, identifier: identifier)
    }
    
    func resolveOptional<T>(_ type: T.Type, identifier: String = "") -> T? {
        let key = makeKey(for: type, identifier: identifier)
        
        // Check if we have an instance in this scope
        if let instance = instances[key] as? T {
            return instance
        }
        
        // Check if we have a registration in this scope
        if let registration = registrations[key] as? DependencyRegistration<T> {
            let instance = registration.factory()
            
            if registration.lifecycle == .singleton {
                instances[key] = instance
            }
            
            return instance
        }
        
        // Fall back to parent container
        return parent.resolveOptional(type, identifier: identifier)
    }
    
    // MARK: - Scope Management
    func reset() {
        registrations.removeAll()
        instances.removeAll()
    }
    
    func remove<T>(_ type: T.Type, identifier: String = "") {
        let key = makeKey(for: type, identifier: identifier)
        registrations.removeValue(forKey: key)
        instances.removeValue(forKey: key)
    }
    
    // MARK: - Helpers
    private func makeKey<T>(for type: T.Type, identifier: String) -> String {
        let typeName = String(describing: type)
        let baseKey = identifier.isEmpty ? typeName : "\(typeName)_\(identifier)"
        return "\(scope.rawValue)_\(baseKey)"
    }
}

// MARK: - Scope Manager
final class DIScopeManager {
    private let container: DIContainer
    private var scopedContainers: [DIScope: ScopedDIContainer] = [:]
    
    init(container: DIContainer = .shared) {
        self.container = container
    }
    
    func scope(_ scope: DIScope) -> ScopedDIContainer {
        if let existing = scopedContainers[scope] {
            return existing
        }
        
        let scopedContainer = ScopedDIContainer(parent: container, scope: scope)
        scopedContainers[scope] = scopedContainer
        return scopedContainer
    }
    
    func resetScope(_ scope: DIScope) {
        scopedContainers[scope]?.reset()
    }
    
    func resetAllScopes() {
        scopedContainers.values.forEach { $0.reset() }
    }
}

// MARK: - Scoped Property Wrapper
@propertyWrapper
struct ScopedInjected<T> {
    private let scope: DIScope
    private let identifier: String
    private var value: T?
    
    init(scope: DIScope, identifier: String = "") {
        self.scope = scope
        self.identifier = identifier
    }
    
    public var wrappedValue: T {
        get {
            if let value = value {
                return value
            }
            let scopedContainer = DIScopeManager().scope(scope)
            let resolved = scopedContainer.resolve(T.self, identifier: identifier)
            // Note: This won't persist the value in structs, but that's fine for DI
            return resolved
        }
        set {
            value = newValue
        }
    }
}

// MARK: - Container Extensions
extension DIContainer {
    static let scopeManager = DIScopeManager()
    
    func scope(_ scope: DIScope) -> ScopedDIContainer {
        Self.scopeManager.scope(scope)
    }
    
    func resetScope(_ scope: DIScope) {
        Self.scopeManager.resetScope(scope)
    }
    
    func resetAllScopes() {
        Self.scopeManager.resetAllScopes()
    }
}
