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
    func handle(_ parameters: Parameters, context: DeepLinkContext) async -> DeepLinkResult
    func mapParametersToDeepLinkParameters(_ parameters: [String: String]) -> Parameters?
}

// MARK: - Protocol Extensions
public extension DeepLinkHandler {
    nonisolated var id: String { String(describing: type(of: self)) }
    
    func handle(_ parameters: [String: String], context: DeepLinkContext) async -> DeepLinkResult {
        guard let parameters = mapParametersToDeepLinkParameters(parameters) else {
            return .failure(.missingRequiredParameters)
        }
        
        return await handle(parameters, context: context)
    }
}

public extension DeepLinkHandler where Parameters == Void {
    func mapParametersToDeepLinkParameters(_ parameters: [String: String]) -> Parameters? {
        ()
    }
}
