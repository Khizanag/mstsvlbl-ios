//
//  ModuleInjected.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 01.09.25.
//

import Foundation

// MARK: - Module Property Wrapper (module name ignored)
@propertyWrapper
public struct ModuleInjected<T> {
    private let identifier: String
    private var value: T?
    
    public init(module: String, identifier: String = "") {
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