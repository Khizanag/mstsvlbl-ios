//
//  QuizDeepLink.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public struct QuizDeepLink: DeepLink {
    public let id: String
    public let path: String
    public let parameters: [String: String]
    public let action: String
    
    public init?(from url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let path = url.path.lowercased()
        let queryItems = components?.queryItems ?? []
        
        let parameters = Dictionary<String, String>(uniqueKeysWithValues: queryItems.compactMap { item in
            guard let value = item.value else { return nil }
            return (item.name, value)
        })
        
        let action = parameters["action"] ?? "view"
        let quizId = parameters["id"] ?? UUID().uuidString
        
        self.id = quizId
        self.path = path
        self.parameters = parameters
        self.action = action
    }
    
    public init?(from path: String, parameters: [String: String]) {
        self.id = parameters["id"] ?? UUID().uuidString
        self.path = path
        self.parameters = parameters
        self.action = parameters["action"] ?? "view"
    }
    
    public init(id: String, action: String, parameters: [String: String] = [:]) {
        self.id = id
        self.path = "quiz"
        self.parameters = parameters
        self.action = action
    }
    
    public func toURL() -> URL? {
        var components = URLComponents()
        components.scheme = "mstsvlbl"
        components.host = "quiz"
        components.queryItems = [
            URLQueryItem(name: "id", value: id),
            URLQueryItem(name: "action", value: action)
        ] + parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url
    }
}
