//
//  DeepLink.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public protocol DeepLink: Hashable, Identifiable, Sendable {
    var path: String { get }
    var parameters: [String: String] { get }
}
