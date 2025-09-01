//
//  DIContainer+Configure.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 01.09.25.
//

import Foundation

// MARK: - Fluent Configuration DSL
extension DIContainer {
    public struct Registrar {
        private let container: DIContainer
        
        init(container: DIContainer) {
            self.container = container
        }
        
        public func singleton<T>(_ type: T.Type, identifier: String = "", _ factory: @escaping () -> T) {
            container.registerSingleton(type, factory: factory, identifier: identifier)
        }
        
        public func factory<T>(_ type: T.Type, identifier: String = "", _ factory: @escaping () -> T) {
            container.register(type, factory: factory, lifecycle: .transient, identifier: identifier)
        }
        
        public func weakRef<T: AnyObject>(_ type: T.Type, identifier: String = "", _ factory: @escaping () -> T) {
            container.registerWeak(type, factory: factory, identifier: identifier)
        }
    }
    
    public static func configure(_ build: (Registrar) -> Void) {
        let registrar = Registrar(container: .shared)
        build(registrar)
    }
}


