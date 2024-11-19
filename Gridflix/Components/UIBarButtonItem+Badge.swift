//
//  UIBarButtonItem+Badge.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 05/11/24.
//

import UIKit

// MARK: - DOES NOT WORK ! !
extension UIBarButtonItem {
    func setBadgeValue(count: Int, offset: CGPoint = .zero, color: UIColor? = .red, filled: Bool = true) {
        guard let view = self.customView else { return }

        let badge = CAShapeLayer()
        let radius: CGFloat = 7.0
        let location = CGPoint(
            x: view.frame.width - (radius + offset.x),
            y: radius + offset.y)
        badge.drawCircleAt(location: location, radius: radius, color: color, filled: filled)
        view.layer.addSublayer(badge)

        let label = CATextLayer()
        label.string = "\(count)"
        label.alignmentMode = .center
        label.fontSize = 11
        label.frame = CGRect(
            x: location.x - 4,
            y: offset.y,
            width: 8,
            height: 16)
        label.foregroundColor = filled ? UIColor.white.cgColor : color?.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen().scale
        badge.addSublayer(label)
    }
}
