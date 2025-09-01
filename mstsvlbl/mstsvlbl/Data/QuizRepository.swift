//
//  QuizRepository.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

protocol QuizRepository {
    func getAll() async throws -> [Quiz]
    func get(by ids: [String]) async throws -> [Quiz]
}

struct LocalQuizRepository: QuizRepository {
    private let resourceExtension = "json"
    private let databaseDirectoryName = "Database"
    
    func getAll() async throws -> [Quiz] {
        let fm = FileManager.default
        print("🔍 QuizRepository: Starting to load quizzes...")
        
        guard let resourcesURL = Bundle.main.resourceURL else {
            print("❌ QuizRepository: Failed to get resources URL")
            return []
        }
        
        let databaseURL = resourcesURL.appendingPathComponent(databaseDirectoryName)
        print("🔍 QuizRepository: Resources URL: \(resourcesURL)")
        print("🔍 QuizRepository: Database URL: \(databaseURL)")
        
        guard fm.fileExists(atPath: databaseURL.path) else {
            print("❌ QuizRepository: Database directory does not exist at: \(databaseURL.path)")
            return []
        }
        
        if let enumerator = fm.enumerator(at: databaseURL, includingPropertiesForKeys: nil) {
            var items: [Quiz] = []
            var jsonFilesFound = 0
            
            while let fileUrl = enumerator.nextObject() as? URL {
                if fileUrl.pathExtension.lowercased() == resourceExtension {
                    jsonFilesFound += 1
                    print("🔍 QuizRepository: Found JSON file: \(fileUrl.lastPathComponent)")
                    
                    if let data = try? Data(contentsOf: fileUrl) {
                        print("🔍 QuizRepository: Loaded data for \(fileUrl.lastPathComponent), size: \(data.count) bytes")
                        
                        if let quiz = try? JSONDecoder().decode(Quiz.self, from: data) {
                            print("🔍 QuizRepository: Successfully decoded quiz: \(quiz.title), coverUrl: \(quiz.coverUrl?.absoluteString ?? "nil")")
                            items.append(quiz)
                        } else {
                            print("❌ QuizRepository: Failed to decode quiz from \(fileUrl.lastPathComponent)")
                        }
                    } else {
                        print("❌ QuizRepository: Failed to load data from \(fileUrl.lastPathComponent)")
                    }
                }
            }
            
            print("🔍 QuizRepository: Found \(jsonFilesFound) JSON files, successfully loaded \(items.count) quizzes")
            if !items.isEmpty { return items }
        } else {
            print("❌ QuizRepository: Failed to create enumerator for database directory")
        }
        
        print("❌ QuizRepository: No quizzes loaded, returning empty array")
        return []
    }
    
    func get(by ids: Set<String>) async throws -> [Quiz] {
        try await getAll()
            .filter { ids.contains($0.id) }
    }
}
