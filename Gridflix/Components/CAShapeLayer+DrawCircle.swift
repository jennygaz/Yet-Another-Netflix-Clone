//
//  CAShapeLayer+DrawCircle.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 05/11/24.
//

import Foundation
import UIKit

extension CAShapeLayer {
    func drawCircleAt(location: CGPoint, radius: CGFloat, color: UIColor?, filled: Bool = true) {
        fillColor = filled ? color?.cgColor : UIColor.white.cgColor
        strokeColor = color?.cgColor
        path = UIBezierPath(
            ovalIn: CGRect(
                x: location.x - radius,
                y: location.y - radius,
                width: radius * 2,
                height: radius * 2)
        ).cgPath
    }
}
