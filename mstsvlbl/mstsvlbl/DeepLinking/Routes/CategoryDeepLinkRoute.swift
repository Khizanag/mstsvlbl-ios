//
//  CategoryDeepLinkRoute.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public final class CategoryDeepLinkRoute: DeepLinkRoute {
    public init() {}
    
    public func route(_ deepLink: any DeepLink) -> DeepLinkDestination? {
        guard let categoryDeepLink = deepLink as? CategoryDeepLink else {
            return nil
        }
        
        return .category(name: categoryDeepLink.id)
    }
}
