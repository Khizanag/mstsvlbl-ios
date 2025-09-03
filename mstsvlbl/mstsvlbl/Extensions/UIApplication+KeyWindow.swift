//
//  UIApplication+KeyWindow.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 03.09.25.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        windows.first(where: { $0.isKeyWindow })
    }
}
