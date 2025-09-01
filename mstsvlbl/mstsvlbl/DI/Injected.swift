//
//  Injected.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

// MARK: - Injected Property Wrapper
@propertyWrapper
public struct Injected<T> {
    private let identifier: String
    private var value: T?
    
    public init(identifier: String = "") {
        self.identifier = identifier
    }
    
    public var wrappedValue: T {
        get {
            if let value = value {
                return value
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

// MARK: - Optional Injected Property Wrapper
@propertyWrapper
public struct OptionalInjected<T> {
    private let identifier: String
    private var value: T?
    
    public init(identifier: String = "") {
        self.identifier = identifier
    }
    
    public var wrappedValue: T? {
        get {
            if let value = value {
                return value
            }
            let resolved = DIContainer.shared.resolveOptional(T.self, identifier: identifier)
            // Note: This won't persist the value in structs, but that's fine for DI
            return resolved
        }
        set {
            value = newValue
        }
    }
}

// MARK: - Lazy Injected Property Wrapper
@propertyWrapper
public struct LazyInjected<T> {
    private let identifier: String
    private var factory: (() -> T)?
    
    public init(identifier: String = "") {
        self.identifier = identifier
    }
    
    public var wrappedValue: T {
        get {
            if let factory = factory {
                return factory()
            }
            let resolved = DIContainer.shared.resolve(T.self, identifier: identifier)
            // Note: This won't persist the factory in structs, but that's fine for DI
            return resolved
        }
    }
}
