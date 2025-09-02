//
//  DeepListURLParser.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public protocol DeepLinkURLParser {
    func parse(_ url: URL) -> (any DeepLink)?
    func getSupportedPaths() -> [String]
}
