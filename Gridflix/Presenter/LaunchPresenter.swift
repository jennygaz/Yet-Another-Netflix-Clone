//
//  LaunchPresenter.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 03/10/24.
//

final class LaunchPresenter: LaunchViewPresenter {
    unowned let view: any LaunchView
    unowned var delegate: (any Coordinator)?
    required init(view: any LaunchView, delegate: (any Coordinator)? = nil) {
        self.view = view
        self.delegate = delegate
    }

    func startLaunch() {
        view.start()
    }

    func finish() {
        delegate?.finish()
    }
}
