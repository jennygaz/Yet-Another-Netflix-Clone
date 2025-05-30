//
//  NiblessTabBarController.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 12/09/24.
//

import UIKit

open class NiblessTabBarController: UITabBarController {
    // MARK: - Methods
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Loading this controller from a nib is unsupported in favor of initializer dependency injection.")
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable, message: "Loading this controller from a nib is unsupported in favor of initializer dependency injection.")
    public required init?(coder: NSCoder) {
        fatalError("Loading this controller from a nib is unsupported in favor of initializer dependency injection.")
    }
}
