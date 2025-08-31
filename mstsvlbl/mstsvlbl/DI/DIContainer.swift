//
//  DIContainer.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

// MARK: - Dependency Lifecycle
enum DependencyLifecycle {
    case singleton
    case transient
    case weak
}

// MARK: - Dependency Registration
struct DependencyRegistration<T> {
    let factory: () -> T
    let lifecycle: DependencyLifecycle
    let identifier: String
    
    init(factory: @escaping () -> T, lifecycle: DependencyLifecycle = .transient, identifier: String = "") {
        self.factory = factory
        self.lifecycle = lifecycle
        self.identifier = identifier
    }
}

// MARK: - Dependency Container
final class DIContainer {
    static let shared = DIContainer()
    
    private var registrations: [String: Any] = [:]
    private var singletons: [String: Any] = [:]
    private var weakReferences: [String: WeakReference] = [:]
    
    private init() {}
    
    // MARK: - Registration
    func register<T>(
        _ type: T.Type,
        factory: @escaping () -> T,
        lifecycle: DependencyLifecycle = .transient,
        identifier: String = ""
    ) {
        let key = makeKey(for: type, identifier: identifier)
        let registration = DependencyRegistration(factory: factory, lifecycle: lifecycle, identifier: identifier)
        registrations[key] = registration
    }
    
    func register<T>(
        _ type: T.Type,
        instance: T,
        identifier: String = ""
    ) {
        let key = makeKey(for: type, identifier: identifier)
        singletons[key] = instance
    }
    
    // MARK: - Resolution
    func resolve<T>(_ type: T.Type, identifier: String = "") -> T {
        let key = makeKey(for: type, identifier: identifier)
        
        // Check if we have a singleton instance
        if let singleton = singletons[key] as? T {
            return singleton
        }
        
        // Check if we have a weak reference
        if let weakRef = weakReferences[key], let instance = weakRef.value as? T {
            return instance
        }
        
        // Check if we have a registration
        guard let registration = registrations[key] as? DependencyRegistration<T> else {
            fatalError("No registration found for type \(T.self) with identifier '\(identifier)'")
        }
        
        let instance = registration.factory()
        
        // Store based on lifecycle
        switch registration.lifecycle {
        case .singleton:
            singletons[key] = instance
        case .weak:
            weakReferences[key] = WeakReference(value: instance)
        case .transient:
            break // Don't store transient instances
        }
        
        return instance
    }
    
    func resolveOptional<T>(_ type: T.Type, identifier: String = "") -> T? {
        let key = makeKey(for: type, identifier: identifier)
        
        // Check singletons
        if let singleton = singletons[key] as? T {
            return singleton
        }
        
        // Check weak references
        if let weakRef = weakReferences[key], let instance = weakRef.value as? T {
            return instance
        }
        
        // Check registrations
        guard let registration = registrations[key] as? DependencyRegistration<T> else {
            return nil
        }
        
        let instance = registration.factory()
        
        // Store based on lifecycle
        switch registration.lifecycle {
        case .singleton:
            singletons[key] = instance
        case .weak:
            weakReferences[key] = WeakReference(value: instance)
        case .transient:
            break
        }
        
        return instance
    }
    
    // MARK: - Container Management
    func reset() {
        registrations.removeAll()
        singletons.removeAll()
        weakReferences.removeAll()
    }
    
    func remove<T>(_ type: T.Type, identifier: String = "") {
        let key = makeKey(for: type, identifier: identifier)
        registrations.removeValue(forKey: key)
        singletons.removeValue(forKey: key)
        weakReferences.removeValue(forKey: key)
    }
    
    // MARK: - Helpers
    private func makeKey<T>(for type: T.Type, identifier: String) -> String {
        let typeName = String(describing: type)
        return identifier.isEmpty ? typeName : "\(typeName)_\(identifier)"
    }
}

// MARK: - Weak Reference Wrapper
private class WeakReference {
    weak var value: AnyObject?
    
    init(value: AnyObject) {
        self.value = value
    }
}

// MARK: - Container Extensions
extension DIContainer {
    func registerSingleton<T>(_ type: T.Type, factory: @escaping () -> T, identifier: String = "") {
        register(type, factory: factory, lifecycle: .singleton, identifier: identifier)
    }
    
    func registerWeak<T>(_ type: T.Type, factory: @escaping () -> T, identifier: String = "") {
        register(type, factory: factory, lifecycle: .weak, identifier: identifier)
    }
}
