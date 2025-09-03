//
//  BookmarksDeepLinkHandler.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking
import SwiftUI
import UIKit

@MainActor
final class BookmarksDeepLinkHandler: DeepLinkHandler {
    let subscribedPath = "bookmarks"
    
    func handle(_ deepLink: DeepLink, context: DeepLinkContext) async {
        let contentView = BookmarksView()
        let hostingController = UIHostingController(rootView: contentView)
        hostingController.modalPresentationStyle = .fullScreen
        
        if let keyWindow = UIApplication.shared.keyWindow,
           let topViewController = keyWindow.topmostViewController {
            topViewController.present(hostingController, animated: true)
        }
    }
}
