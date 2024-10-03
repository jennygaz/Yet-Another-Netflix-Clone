//
//  ProfileShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 12/09/24.
//

import SwiftUI

struct ProfileShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            // Make first eye, 40% height, 5% width
            path.move(to: CGPoint(
                x: rect.minX + rect.width * 0.125,
                y: rect.midY - rect.height * 0.10))
            path.addArc(
                center: CGPoint(
                    x: rect.minX + rect.width * 0.125,
                    y: rect.midY - rect.height * 0.10),
                radius: rect.width * 0.05,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: true)
            // Make second eye, 40% height, 5% width
            path.move(to: CGPoint(
                x: rect.maxX - rect.width * 0.125,
                y: rect.midY - rect.height * 0.10))
            path.addArc(
                center: CGPoint(
                    x: rect.maxX - rect.width * 0.125,
                    y: rect.midY - rect.height * 0.10),
                radius: rect.width * 0.05,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
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
                control1: CGPoint(
                    x: rect.midX - rect.width * 0.20,
                    y: rect.midY + rect.height * 0.125),
                control2: CGPoint(
                    x: rect.midX + rect.width * 0.1,
                    y: rect.midY + rect.height * 0.14))
            path.addCurve(
                to: CGPoint(
                    x: rect.midX + rect.width * 0.40,
                    y: rect.midY + rect.height * 0.05),
                control1: CGPoint(
                    x: rect.midX + rect.width * 0.11,
                    y: rect.midY + rect.height * 0.14),
                control2: CGPoint(
                    x: rect.midX + rect.width * 0.45,
                    y: rect.midY + rect.height * 0.125))
            path.addCurve(
                to: CGPoint(
                    x: rect.midX + rect.width * 0.10,
                    y: rect.midY + rect.height * 0.0565),
                control1: CGPoint(
                    x: rect.midX + rect.width * 0.35,
                    y: rect.midY - rect.height * 0.025),
                control2: CGPoint(
                    x: rect.midX + rect.width * 0.12,
                    y: rect.midY + rect.height * 0.085))
            path.addCurve(
                to: CGPoint(
                    x: rect.midX - rect.width * 0.15,
                    y: rect.midY + rect.height * 0.05),
                control1: CGPoint(
                    x: rect.midX + rect.width * 0.12,
                    y: rect.midY + rect.height * 0.085),
                control2: CGPoint(
                    x: rect.midX - rect.width * 0.12,
                    y: rect.midY - rect.height * 0.025))
            path.closeSubpath()
        }
    }
}

#Preview {
    Group {
        ProfileShape()
            .frame(width: 300, height: 300, alignment: .center)
            .background(Color.red)
        ProfileShape()
            .frame(width: 30, height: 30, alignment: .center)
            .background(Color.red)
    }
}
