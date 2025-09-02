//
//  DeepLinkMetadata.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public struct DeepLinkMetadata {
    public let id: String
    public let type: String
    public let priority: DeepLinkPriority
    public let requiresAuthentication: Bool
    public let supportedPlatforms: Set<DeepLinkPlatform>
    public let version: String
    public let description: String
    
    public init(
        id: String,
        type: String,
        priority: DeepLinkPriority = .normal,
        requiresAuthentication: Bool = false,
        supportedPlatforms: Set<DeepLinkPlatform> = [.iOS, .macOS],
        version: String = "1.0.0",
        description: String = ""
    ) {
        self.id = id
        self.type = type
        self.priority = priority
        self.requiresAuthentication = requiresAuthentication
        self.supportedPlatforms = supportedPlatforms
        self.version = version
        self.description = description
    }
}
