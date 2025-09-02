//
//  DeepLink.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation
import SwiftUI

// MARK: - DeepLink Protocol
public protocol DeepLink: Hashable, Identifiable {
    var id: String { get }
    var path: String { get }
    var parameters: [String: String] { get }
    
    init?(from url: URL)
    init?(from path: String, parameters: [String: String])
    
    func toURL() -> URL?
}
