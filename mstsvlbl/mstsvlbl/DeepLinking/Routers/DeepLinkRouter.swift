//
//  DeepLinkRouter.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Router
public final class DeepLinkRouter {
    private var routes: [String: DeepLinkRoute] = [:]
    private var fallbackRoute: DeepLinkRoute?
    private var navigationCoordinator: DeepLinkNavigationCoordinator?
    
    public init() {}
    
    public func register(_ route: DeepLinkRoute, for path: String) {
        routes[path] = route
    }
    
    public func setFallbackRoute(_ route: DeepLinkRoute) {
        fallbackRoute = route
    }
    
    public func setNavigationCoordinator(_ coordinator: DeepLinkNavigationCoordinator) {
        navigationCoordinator = coordinator
    }
    
    public func route(_ deepLink: any DeepLink) -> DeepLinkDestination? {
        let path = deepLink.path
        
        // Try to find a specific route
        if let route = routes[path] {
            return route.route(deepLink)
        }
        
        // Try fallback route
        if let fallbackRoute = fallbackRoute {
            return fallbackRoute.route(deepLink)
        }
        
        return nil
    }
    
    public func getRegisteredRoutes() -> [String] {
        Array(routes.keys)
    }
}

// MARK: - DeepLink Route Protocol
public protocol DeepLinkRoute {
    func route(_ deepLink: any DeepLink) -> DeepLinkDestination?
}

// MARK: - DeepLink Navigation Coordinator Protocol
public protocol DeepLinkNavigationCoordinator: AnyObject {
    func navigate(to destination: DeepLinkDestination)
    func canNavigate(to destination: DeepLinkDestination) -> Bool
}
