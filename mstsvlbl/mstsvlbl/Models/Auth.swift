//
//  Auth.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 30.08.25.
//

import Foundation
import AuthenticationServices
import Observation

@MainActor
@Observable
final class AuthService: NSObject {
    enum State { case signedOut, signingIn, signedIn }

    private(set) var state: State = .signedOut
    private(set) var userIdentifier: String? = nil

    func signInWithApple() {
        state = .signingIn
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    func signOut() {
        userIdentifier = nil
        state = .signedOut
    }
}

extension AuthService: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            userIdentifier = credential.user
            state = .signedIn
        } else {
            state = .signedOut
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        state = .signedOut
    }
}

extension AuthService: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}


