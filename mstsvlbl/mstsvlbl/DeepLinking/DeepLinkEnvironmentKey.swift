//
//  DeepLinkEnvironmentKey.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import SwiftUI

// MARK: - Deep Link Navigation Coordinator Environment Key
private struct DeepLinkNavigationCoordinatorKey: EnvironmentKey {
    static let defaultValue: DeepLinkNavigationCoordinator? = nil
}

// MARK: - Environment Extension
extension EnvironmentValues {
    var deepLinkNavigationCoordinator: DeepLinkNavigationCoordinator? {
        get { self[DeepLinkNavigationCoordinatorKey.self] }
        set { self[DeepLinkNavigationCoordinatorKey.self] = newValue }
    }
}
