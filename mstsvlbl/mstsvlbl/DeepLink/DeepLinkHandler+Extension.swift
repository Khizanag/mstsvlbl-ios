//
//  DeepLinkHandler+Extension.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 03.09.25.
//

import Mstsvlbl_Core_DeepLinking
import SwiftUI
import UIKit

extension DeepLinkHandler {
    func presentViewOnTop<V: View>(_ view: V) {
        let navigatorView = NavigatorView {
            view
        }
        
        let hostingController = UIHostingController(rootView: navigatorView)
        hostingController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        if let topmostViewController = UIApplication.shared.keyWindow?.topmostViewController {
            topmostViewController.present(hostingController, animated: true)
        } else if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.rootViewController = hostingController
            keyWindow.makeKeyAndVisible()
        }
    }
}
