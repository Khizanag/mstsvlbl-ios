//
//  DeepLinkHandler.swift
//  Mstsvlbl_Core_DeepLinking
//
// Created by Giga Khizanishvili on 02.09.25.
//

public protocol DeepLinkHandler: Identifiable, Sendable {
    associatedtype Parameters
    var host: String { get }
    func handle(_ parameters: [String: String], context: DeepLinkContext) async -> DeepLinkResult
    func mapParametersToDeepLinkParameters(_ parameters: [String: String]) async -> Parameters?
}

// MARK: - Protocol Extensions
public extension DeepLinkHandler {
    nonisolated var id: String { String(describing: type(of: self)) }
}

public extension DeepLinkHandler where Parameters == Never {
    func mapParametersToDeepLinkParameters(_ parameters: [String: String]) async -> Parameters? {
        nil
    }
}
