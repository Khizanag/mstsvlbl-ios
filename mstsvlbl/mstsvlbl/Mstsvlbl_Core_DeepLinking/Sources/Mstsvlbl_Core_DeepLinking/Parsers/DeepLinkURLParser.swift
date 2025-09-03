//
//  DeepLinkURLParser.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 03.09.25.
//

import Foundation

public protocol DeepLinkURLParser: Sendable {
    func parse(_ url: URL) -> DeepLink?
}
