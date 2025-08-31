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

struct BundleQuizRepository: QuizRepository {
    private let resourceExtension = "json"
    private let databaseDirectoryName = "Database"

    func getAll() async throws -> [Quiz] {
        let fm = FileManager.default
        if let resourcesURL = Bundle.main.resourceURL,
           let enumerator = fm.enumerator(at: resourcesURL, includingPropertiesForKeys: nil) {
            var items: [Quiz] = []
            for case let fileUrl as URL in enumerator {
                guard fileUrl.pathExtension.lowercased() == resourceExtension else { continue }
                if let data = try? Data(contentsOf: fileUrl),
                   let quiz = try? JSONDecoder().decode(Quiz.self, from: data) {
                    items.append(quiz)
                }
            }
            if !items.isEmpty { return items }
        }

        return []
    }

    func get(by ids: [String]) async throws -> [Quiz] {
        let all = try await getAll()
        let set = Set(ids)
        return all.filter { set.contains($0.id) }
    }
}
