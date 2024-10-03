//
//  LaunchViewPresenter.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 03/10/24.
//

protocol LaunchViewPresenter {
    var delegate: (any Coordinator)? { get }
    init(view: any LaunchView, delegate: (any Coordinator)?)
    func startLaunch()
    func finish()
}
