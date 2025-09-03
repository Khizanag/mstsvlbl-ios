//
//  DeepLinkResult.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public enum DeepLinkResult: Sendable {
    case success
    case failure(DeepLinkError)
}
