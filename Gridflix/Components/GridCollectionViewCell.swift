//
//  GridCollectionViewCell.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 13/09/24.
//

import UIKit
import SwiftUI

final class GridCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var color: UIColor = .systemRed {
        didSet {
            let swiftUIView = ProfileIconView(backgroundColor: color)
                .frame(width: 100, height: 100, alignment: .center)
            let hosting = UIHostingController(rootView: swiftUIView)
            let subviewsCopy = subviews
            subviewsCopy.forEach { view in
                view.removeFromSuperview()
            }
            addSubview(hosting.view)
        }
    }

    override init(frame: CGRect) {
        let swiftUIView = ProfileIconView(backgroundColor: color)
            .frame(width: 100, height: 100, alignment: .center)
        let hosting = UIHostingController(rootView: swiftUIView)
        super.init(frame: frame)
        addSubview(hosting.view)
    }

    @available(*, unavailable, message: "Deprecated in favour of dependency injection approach")
    required init?(coder: NSCoder) {
        fatalError("Deprecated in favour of dependency injection approach")
    }
}

enum GridSection: Hashable, CaseIterable {
    case main
}
