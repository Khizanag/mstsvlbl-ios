//
//  DeepLinkResult.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public enum DeepLinkResult: Sendable {
    case success
    case failure(DeepLinkError)
}
