//
//  UIView+Extension.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 14/09/24.
//

import UIKit
import SwiftUI

extension UIView {
    func drawCustomShape() {
        //create shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = UIColor.white.cgColor
        
        self.layer.addSublayer(shapeLayer)
        
        //create path
        let path = UIBezierPath()
        let rect = frame
        
        // Make first eye, 40% height, 5% width
        path.move(to: CGPoint(
            x: rect.minX + rect.width * 0.125,
            y: rect.midY - rect.height * 0.10))
        path.addArc(
            withCenter: CGPoint(
                x: rect.minX + rect.width * 0.125,
                y: rect.midY - rect.height * 0.10),
            radius: rect.width * 0.05,
            startAngle: CGFloat(Angle(degrees: 0).radians),
            endAngle: CGFloat(Angle(degrees: 360).radians),
            clockwise: true)
        // Make second eye, 40% height, 5% width
        path.move(to: CGPoint(
            x: rect.maxX - rect.width * 0.125,
            y: rect.midY - rect.height * 0.10))
        path.addArc(
            withCenter: CGPoint(
                x: rect.maxX - rect.width * 0.125,
                y: rect.midY - rect.height * 0.10),
            radius: rect.width * 0.05,
            startAngle: CGFloat(Angle(degrees: 0).radians),
            endAngle: CGFloat(Angle(degrees: 360).radians),
            clockwise: true)
        // Make smile
        // Important points
        /*
         * Leading edge center:
            CGPoint(
                x: rect.midX - rect.width * 0.15,
                y: rect.midY)
         * Trailing edge center:
            CGPoint(
                x: rect.midX + rect.width * 0.40,
                y: rect.midY)
         * Bottom edge center:
            CGPoint(
                x: rect.midX + rect.width * 0.1,
                y: rect.midY + rect.height * 0.15)
         * Top edge center:
            CGPoint(
                x: rect.midX + rect.width * 0.1,
                y: rect.midY + rect.height * 0.05)
         */
        path.move(to: CGPoint(
            x: rect.midX - rect.width * 0.15,
            y: rect.midY + rect.height * 0.05))
        path.addCurve(
            to: CGPoint(
                x: rect.midX + rect.width * 0.10,
                y: rect.midY + rect.height * 0.135),
            controlPoint1: CGPoint(
                x: rect.midX - rect.width * 0.20,
                y: rect.midY + rect.height * 0.125),
            controlPoint2: CGPoint(
                x: rect.midX + rect.width * 0.1,
                y: rect.midY + rect.height * 0.14))
        path.addCurve(
            to: CGPoint(
                x: rect.midX + rect.width * 0.40,
                y: rect.midY + rect.height * 0.05),
            controlPoint1: CGPoint(
                x: rect.midX + rect.width * 0.11,
                y: rect.midY + rect.height * 0.14),
            controlPoint2: CGPoint(
                x: rect.midX + rect.width * 0.45,
                y: rect.midY + rect.height * 0.125))
        path.addCurve(
            to: CGPoint(
                x: rect.midX + rect.width * 0.10,
                y: rect.midY + rect.height * 0.0565),
            controlPoint1: CGPoint(
                x: rect.midX + rect.width * 0.35,
                y: rect.midY - rect.height * 0.025),
            controlPoint2: CGPoint(
                x: rect.midX + rect.width * 0.12,
                y: rect.midY + rect.height * 0.085))
        path.addCurve(
            to: CGPoint(
                x: rect.midX - rect.width * 0.15,
                y: rect.midY + rect.height * 0.05),
            controlPoint1: CGPoint(
                x: rect.midX + rect.width * 0.12,
                y: rect.midY + rect.height * 0.085),
            controlPoint2: CGPoint(
                x: rect.midX - rect.width * 0.12,
                y: rect.midY - rect.height * 0.025))
        path.close()
        
        shapeLayer.path = path.cgPath
    }
}

@available(iOS 17, *)
#Preview("UIKit") {
    let vc = UIViewController()
    let customView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    customView.backgroundColor = .systemRed
    customView.drawCustomShape()
    vc.view.addSubview(customView)
    customView.translatesAutoresizingMaskIntoConstraints = false
    let constraints: [NSLayoutConstraint] = [
        customView.heightAnchor.constraint(equalToConstant: 100),
        customView.widthAnchor.constraint(equalToConstant: 100),
        customView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
        customView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
    vc.view.backgroundColor = .clear
    
    return vc
}
