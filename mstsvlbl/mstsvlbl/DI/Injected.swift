//
//  Injected.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

// MARK: - Injected Property Wrapper
@propertyWrapper
struct Injected<T> {
    private let identifier: String
    private var value: T?
    
    init(identifier: String = "") {
        self.identifier = identifier
    }
    
    var wrappedValue: T {
        get {
            if let value = value {
                return value
            }
            let resolved = DIContainer.shared.resolve(T.self, identifier: identifier)
            value = resolved
            return resolved
        }
        set {
            value = newValue
        }
    }
}

// MARK: - Optional Injected Property Wrapper
@propertyWrapper
struct OptionalInjected<T> {
    private let identifier: String
    private var value: T?
    
    init(identifier: String = "") {
        self.identifier = identifier
    }
    
    var wrappedValue: T? {
        get {
            if let value = value {
                return value
            }
            let resolved = DIContainer.shared.resolveOptional(T.self, identifier: identifier)
            value = resolved
            return resolved
        }
        set {
            value = newValue
        }
    }
}

// MARK: - Lazy Injected Property Wrapper
@propertyWrapper
struct LazyInjected<T> {
    private let identifier: String
    private var factory: (() -> T)?
    
    init(identifier: String = "") {
        self.identifier = identifier
    }
    
    var wrappedValue: T {
        get {
            if let factory = factory {
                return factory()
            }
            let resolved = DIContainer.shared.resolve(T.self, identifier: identifier)
            factory = { resolved }
            return resolved
        }
    }
}
