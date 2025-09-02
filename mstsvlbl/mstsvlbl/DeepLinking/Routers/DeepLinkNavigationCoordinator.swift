//
//  DeepLinkNavigationCoordinator.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public protocol DeepLinkNavigationCoordinator: AnyObject {
    func navigate(to destination: DeepLinkDestination)
    func canNavigate(to destination: DeepLinkDestination) -> Bool
}
