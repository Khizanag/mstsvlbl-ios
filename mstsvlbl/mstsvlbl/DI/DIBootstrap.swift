//
//  DIBootstrap.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 01.09.25.
//

import Mstsvlbl_Core_DeepLinking

public enum DIBootstrap {
    public static func bootstrap() {
        DIContainer.configure { r in
            r.singleton(AuthService.self) { AuthService() }
            r.singleton(UserStore.self) { UserStore() }
            r.factory(QuizRepository.self) { LocalQuizRepository() }
            r.factory(GetDiscoverQuizzesUseCase.self) { DefaultGetDiscoverQuizzesUseCase() }
            r.factory(GetBookmarkedQuizzesUseCase.self) { DefaultGetBookmarkedQuizzesUseCase() }
            r.factory(BookmarksViewModel.self) { BookmarksViewModel() }
            r.factory(QuizListViewModel.self) { QuizListViewModel() }
            r.factory(QuizViewModel.self) { QuizViewModel() }
            
            // Deep Linking
            r.singleton(DeepLinkManager.self) { DefaultDeepLinkManager() }
        }
    }
}
