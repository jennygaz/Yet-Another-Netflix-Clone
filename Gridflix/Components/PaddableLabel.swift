//
//  PaddableLabel.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 05/11/24.
//

import UIKit

final class PaddableLabel: UILabel {
    // MARK: - Properties
    var edgeInsets: UIEdgeInsets = .zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: edgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(
            top: -edgeInsets.top,
            left: -edgeInsets.left,
            bottom: -edgeInsets.bottom,
            right: -edgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }

    var leftPadding: CGFloat {
        set { edgeInsets.left = newValue }
        get { edgeInsets.left }
    }

    var rightPadding: CGFloat {
        set { edgeInsets.right = newValue }
        get { edgeInsets.right }
    }

    var topPadding: CGFloat {
        set { edgeInsets.top = newValue }
        get { edgeInsets.top }
    }

    var bottomPadding: CGFloat {
        set { edgeInsets.bottom = newValue }
        get { edgeInsets.bottom }
    }
}
