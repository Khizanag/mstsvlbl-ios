//
//  DeepLinkSubscriber+Extension.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 03.09.25.
//

import SwiftUI
import UIKit
import Mstsvlbl_Core_DeepLinking

extension DeepLinkSubscriber {
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
