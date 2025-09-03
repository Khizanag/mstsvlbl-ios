//
//  QuizRepository.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

public protocol QuizRepository {
    func getAll() async throws -> [Quiz]
    func get(by ids: Set<String>) async throws -> [Quiz]
}

public struct LocalQuizRepository: QuizRepository {
    private let resourceExtension = "json"
    
    public init() {}
    
    public func getAll() async throws -> [Quiz] {
        let fm = FileManager.default
        
        guard let resourcesURL = Bundle.main.resourceURL else {
            print("❌ QuizRepository: Failed to get resources URL")
            return []
        }
        
        // Look for JSON files directly in the resources directory
        let jsonFiles = try fm.contentsOfDirectory(at: resourcesURL, includingPropertiesForKeys: nil)
            .filter { $0.pathExtension.lowercased() == resourceExtension }
        
        
        var items: [Quiz] = []
        
        for fileUrl in jsonFiles {
            do {
                let data = try Data(contentsOf: fileUrl)
                let quiz = try JSONDecoder().decode(Quiz.self, from: data)
                items.append(quiz)
            } catch {
                print("❌ QuizRepository: Failed to process \(fileUrl.lastPathComponent): \(error)")
            }
        }
        
        return items
    }
    
    public func get(by ids: Set<String>) async throws -> [Quiz] {
        try await getAll()
            .filter { ids.contains($0.id) }
    }
}
