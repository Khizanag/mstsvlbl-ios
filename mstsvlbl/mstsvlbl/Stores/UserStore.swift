//
//  UserStore.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation
import Observation

@Observable
final class UserStore {
    private let storageKey = "user_store_v1"

    var user: User {
        didSet {
            persist()
        }
    }

    // MARK: - Init
    init() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let loaded = try? JSONDecoder().decode(User.self, from: data) {
            self.user = loaded
        } else {
            self.user = User(name: "Guest", bookmarks: [], featured: [], history: [])
        }
    }

    func toggleBookmark(quizId: String) {
        if user.bookmarks.contains(quizId) {
            user.bookmarks.remove(quizId)
        } else {
            user.bookmarks.insert(quizId)
        }
    }

    func addPlayRecord(quizId: String, score: Int, total: Int) {
        let record = PlayRecord(id: UUID(), quizId: quizId, date: Date(), score: score, total: total)
        user.history.insert(record, at: 0)
    }

    func setFeaturedIfEmpty(using quizzes: [Quiz]) {
        guard user.featured.isEmpty else { return }
        let top5 = quizzes
            .sorted { $0.questions.count > $1.questions.count }
            .prefix(5)
            .map { $0.id }
        user.featured = Array(top5)
    }
}

// MARK: - Private
private extension UserStore {
    func persist() {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
}
