//
//  QuizListViewModel.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation
import Observation

@MainActor
@Observable
final class QuizListViewModel {
    private(set) var quizzes: [Quiz] = []
    private(set) var isLoading = false
    private var originalQuizzes: [Quiz] = []
    var selectedSort: SortOption = .default {
        didSet {
            applySort(selectedSort)
        }
    }

    private let repository: QuizRepository

    init(repository: QuizRepository = BundleQuizRepository()) {
        self.repository = repository
    }

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let loaded = try await repository.getAllQuizzes()
            originalQuizzes = loaded
            quizzes = loaded
        } catch {
            print("Failed to load quizzes: \(error)")
            quizzes = []
        }
    }

    enum SortOption: String, CaseIterable, Identifiable {
        case `default`
        case alphabeticalAsc
        case alphabeticalDesc
        case questionCountAsc
        case questionCountDesc

        var id: String { rawValue }

        var title: String {
            switch self {
            case .default:
                "Default Order"
            case .alphabeticalAsc:
                "Title · A → Z"
            case .alphabeticalDesc:
                "Title · Z → A"
            case .questionCountAsc:
                "Questions · Fewest First"
            case .questionCountDesc:
                "Questions · Most First"
            }
        }
    }

    func applySort(_ option: SortOption) {
        quizzes = switch option {
        case .default:
            originalQuizzes
        case .alphabeticalAsc:
             originalQuizzes.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        case .alphabeticalDesc:
            originalQuizzes.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedDescending }
        case .questionCountAsc:
            originalQuizzes.sorted { $0.questions.count < $1.questions.count }
        case .questionCountDesc:
            originalQuizzes.sorted { $0.questions.count > $1.questions.count }
        }
    }
}
