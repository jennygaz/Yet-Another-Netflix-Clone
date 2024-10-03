//
//  WelcomePresenter.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 03/10/24.
//

final class WelcomePresenter: WelcomeViewPresenter {
    unowned let view: any WelcomeView
    unowned var delegate: (any Coordinator)?
    required init(view: any WelcomeView, delegate: (any Coordinator)? = nil) {
        self.view = view
        self.delegate = delegate
    }

    func registerFlow() {
        
    }

    func privacyFlow() {
        
    }

    func signInFlow() {
        
    }
}
