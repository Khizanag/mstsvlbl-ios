//
//  DIFactory.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation
import ObjectiveC

// MARK: - Factory Protocol
protocol DIFactory {
    associatedtype T
    func create() -> T
}

// MARK: - Parameterized Factory Protocol
protocol ParameterizedDIFactory {
    associatedtype T
    associatedtype Parameters
    func create(with parameters: Parameters) -> T
}

// MARK: - Factory Registration
struct FactoryRegistration<T> {
    let factory: () -> T
    let identifier: String
    
    init(factory: @escaping () -> T, identifier: String = "") {
        self.factory = factory
        self.identifier = identifier
    }
}

// MARK: - Parameterized Factory Registration
struct ParameterizedFactoryRegistration<T, P> {
    let factory: (P) -> T
    let identifier: String
    
    init(factory: @escaping (P) -> T, identifier: String = "") {
        self.factory = factory
        self.identifier = identifier
    }
}

// MARK: - Factory Container Extension
extension DIContainer {
    private var factories: [String: Any] {
        get { objc_getAssociatedObject(self, &AssociatedKeys.factories) as? [String: Any] ?? [:] }
        set { objc_setAssociatedObject(self, &AssociatedKeys.factories, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var parameterizedFactories: [String: Any] {
        get { objc_getAssociatedObject(self, &AssociatedKeys.parameterizedFactories) as? [String: Any] ?? [:] }
        set { objc_setAssociatedObject(self, &AssociatedKeys.parameterizedFactories, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    
    // MARK: - Factory Registration
    func registerFactory<T>(_ type: T.Type, factory: @escaping () -> T, identifier: String = "") {
        let key = makeKey(for: type, identifier: identifier)
        let registration = FactoryRegistration(factory: factory, identifier: identifier)
        factories[key] = registration
    }
    
    func registerParameterizedFactory<T, P>(_ type: T.Type, factory: @escaping (P) -> T, identifier: String = "") {
        let key = makeKey(for: type, identifier: identifier)
        let registration = ParameterizedFactoryRegistration(factory: factory, identifier: identifier)
        parameterizedFactories[key] = registration
    }
    
    // MARK: - Factory Resolution
    func create<T>(_ type: T.Type, identifier: String = "") -> T {
        let key = makeKey(for: type, identifier: identifier)
        
        guard let registration = factories[key] as? FactoryRegistration<T> else {
            fatalError("No factory registration found for type \(T.self) with identifier '\(identifier)'")
        }
        
        return registration.factory()
    }
    
    func create<T, P>(_ type: T.Type, with parameters: P, identifier: String = "") -> T {
        let key = makeKey(for: type, identifier: identifier)
        
        guard let registration = parameterizedFactories[key] as? ParameterizedFactoryRegistration<T, P> else {
            fatalError("No parameterized factory registration found for type \(T.self) with identifier '\(identifier)'")
        }
        
        return registration.factory(parameters)
    }
    
    func createOptional<T>(_ type: T.Type, identifier: String = "") -> T? {
        let key = makeKey(for: type, identifier: identifier)
        
        guard let registration = factories[key] as? FactoryRegistration<T> else {
            return nil
        }
        
        return registration.factory()
    }
    
    func createOptional<T, P>(_ type: T.Type, with parameters: P, identifier: String = "") -> T? {
        let key = makeKey(for: type, identifier: identifier)
        
        guard let registration = parameterizedFactories[key] as? ParameterizedFactoryRegistration<T, P> else {
            return nil
        }
        
        return registration.factory(parameters)
    }
}

// MARK: - Associated Keys
private struct AssociatedKeys {
    static var factories = "factories"
    static var parameterizedFactories = "parameterizedFactories"
}

// MARK: - Factory Property Wrapper
@propertyWrapper
struct Factory<T> {
    private let identifier: String
    
    init(identifier: String = "") {
        self.identifier = identifier
    }
    
    var wrappedValue: T {
        DIContainer.shared.create(T.self, identifier: identifier)
    }
}

// MARK: - Parameterized Factory Property Wrapper
@propertyWrapper
struct ParameterizedFactory<T, P> {
    private let identifier: String
    private let parameters: P
    
    init(parameters: P, identifier: String = "") {
        self.parameters = parameters
        self.identifier = identifier
    }
    
    var wrappedValue: T {
        DIContainer.shared.create(T.self, with: parameters, identifier: identifier)
    }
}
