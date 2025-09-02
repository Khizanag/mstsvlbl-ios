//
//  QuizRepository.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

protocol QuizRepository {
    func getAll() async throws -> [Quiz]
    func get(by ids: Set<String>) async throws -> [Quiz]
}

struct LocalQuizRepository: QuizRepository {
    private let resourceExtension = "json"
    
    func getAll() async throws -> [Quiz] {
        let fm = FileManager.default
        print("🔍 QuizRepository: Starting to load quizzes...")
        
        guard let resourcesURL = Bundle.main.resourceURL else {
            print("❌ QuizRepository: Failed to get resources URL")
            return []
        }
        
        print("🔍 QuizRepository: Resources URL: \(resourcesURL)")
        
        // Debug: List all contents of the resources directory
        if let resourceContents = try? fm.contentsOfDirectory(at: resourcesURL, includingPropertiesForKeys: nil) {
            print("🔍 QuizRepository: Resources directory contains: \(resourceContents.map { $0.lastPathComponent })")
        }
        
        // Look for JSON files directly in the resources directory
        let jsonFiles = try fm.contentsOfDirectory(at: resourcesURL, includingPropertiesForKeys: nil)
            .filter { $0.pathExtension.lowercased() == resourceExtension }
        
        print("🔍 QuizRepository: Found \(jsonFiles.count) JSON files directly in resources")
        
        var items: [Quiz] = []
        
        for fileUrl in jsonFiles {
            print("🔍 QuizRepository: Processing JSON file: \(fileUrl.lastPathComponent)")
            
            do {
                let data = try Data(contentsOf: fileUrl)
                print("🔍 QuizRepository: Loaded data for \(fileUrl.lastPathComponent), size: \(data.count) bytes")
                
                let quiz = try JSONDecoder().decode(Quiz.self, from: data)
                print("🔍 QuizRepository: Successfully decoded quiz: \(quiz.title), coverUrl: \(quiz.coverUrl?.absoluteString ?? "nil")")
                items.append(quiz)
            } catch {
                print("❌ QuizRepository: Failed to process \(fileUrl.lastPathComponent): \(error)")
            }
        }
        
        return items
    }
    
    func get(by ids: Set<String>) async throws -> [Quiz] {
        try await getAll()
            .filter { ids.contains($0.id) }
    }
}
