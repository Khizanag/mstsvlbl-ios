//
//  ProfileDeepLinkRoute.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public final class ProfileDeepLinkRoute: DeepLinkRoute {
    public init() {}
    
    public func route(_ deepLink: any DeepLink) -> DeepLinkDestination? {
        guard let profileDeepLink = deepLink as? ProfileDeepLink else {
            return nil
        }
        
        return .profile(action: profileDeepLink.action)
    }
}
