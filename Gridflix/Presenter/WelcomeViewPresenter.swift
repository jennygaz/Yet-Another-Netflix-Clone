//
//  WelcomeViewPresenter.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 03/10/24.
//

protocol WelcomeViewPresenter {
    var delegate: (any Coordinator)? { get }
    init(view: any WelcomeView, delegate: (any Coordinator)?)
    func privacyFlow()
    func signInFlow()
    func registerFlow()
}
