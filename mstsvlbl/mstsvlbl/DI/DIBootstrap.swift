//
//  DIBootstrap.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 01.09.25.
//

import Foundation

public enum DIBootstrap {
    public static func bootstrap() {
        DIContainer.configure { r in
            r.singleton(AuthService.self) { AuthService() }
            r.singleton(UserStore.self) { UserStore() }
            r.factory(QuizRepository.self) { BundleQuizRepository() }
            r.factory(DiscoverQuizzesRepository.self) { RandomDiscoverQuizzesRepository() }
            r.factory(GetBookmarkedQuizzesUseCase.self) {
                let repository: QuizRepository = DIContainer.shared.resolve(QuizRepository.self)
                return DefaultGetBookmarkedQuizzesUseCase(repository: repository) as GetBookmarkedQuizzesUseCase
            }
            r.factory(BookmarksViewModel.self) { BookmarksViewModel() }
            r.factory(QuizListViewModel.self) { QuizListViewModel() }
            r.factory(QuizViewModel.self) { QuizViewModel() }
        }
    }
}


