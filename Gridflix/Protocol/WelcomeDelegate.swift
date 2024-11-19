//
//  WelcomeDelegate.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 02/10/24.
//

import UIKit

@MainActor
public protocol WelcomeDelegate: AnyObject {
    func signIn()
    func privacy()
    func register()
}
