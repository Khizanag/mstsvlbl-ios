//
//  CategoryDeepLinkHandler.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking

@MainActor
final class CategoryDeepLinkHandler: DeepLinkHandler {
    let subscribedPath = "category"
    
    func handle(_ deepLink: DeepLink, context: DeepLinkContext) async {
        guard let categoryId = deepLink.parameters["id"],
              let category = Category(rawValue: categoryId.lowercased()) else { return }
        
        let page = Page.category(category)
        presentViewOnTop(page())
    }
}
