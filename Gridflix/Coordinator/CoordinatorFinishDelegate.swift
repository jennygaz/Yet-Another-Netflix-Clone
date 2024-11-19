//
//  CoordinatorFinishDelegate.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 19/09/24.
//

@MainActor
protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(child: any Coordinator)
}
