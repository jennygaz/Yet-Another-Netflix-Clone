//
//  DependencyContainer.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 12/09/24.
//

import Foundation
import UIKit

public protocol DependencyContainer {
    var sessionRepository: any SessionRepository { get }
    var mainPresenter: any MainPresenter { get }
}
