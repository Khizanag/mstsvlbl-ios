//
//  DeepLinkRoute.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public protocol DeepLinkRoute {
    func route(_ deepLink: any DeepLink) -> DeepLinkDestination?
}
