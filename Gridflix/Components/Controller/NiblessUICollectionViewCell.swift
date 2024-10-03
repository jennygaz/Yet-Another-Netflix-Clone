//
//  NiblessTabBarController.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 12/09/24.
//

import UIKit

open class NiblessUICollectionViewCell: UICollectionViewCell {
    @available(*, unavailable, message: "Loading this controller from a nib is unsupported in favor of initializer dependency injection.")
    public required init?(coder: NSCoder) {
        fatalError("Loading this controller from a nib is unsupported in favor of initializer dependency injection.")
    }
}
