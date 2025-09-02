//
//  DeepLink.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation
import SwiftUI

// MARK: - DeepLink Protocol
public protocol DeepLink: Hashable, Identifiable, Sendable {
    var path: String { get }
    var parameters: [String: String] { get }
}
