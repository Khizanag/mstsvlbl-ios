//
//  DeepLinkManager.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public protocol DeepLinkManager: Sendable {
    func handle(url: URL) async
    func handle(universalLink: URL) async
    func register(_ handler: any DeepLinkHandler) async
    func unregister(_ handler: any DeepLinkHandler) async
}
