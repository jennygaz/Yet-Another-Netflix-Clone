//
//  ThreeShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 10/11/24.
//


import SwiftUI

struct ThreeShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(
                x: rect.minX + rect.width / 6.0,
                y: rect.minY + 2.4 * rect.height / 6.0))
            path.addLine(to: CGPoint(
                x: rect.minX + rect.width / 3.0,
                y: rect.minY + 2.4 * rect.height / 6.0))
            path.addCurve(
                to: CGPoint(
                    x: rect.minX + rect.width / 3.0,
                    y: rect.minY + 11 * rect.height / 24.0),
                control1: CGPoint(
                    x: rect.minX + 4.4 * rect.width / 6.0,
                    y: rect.minY + 6 * rect.height / 24.0),
                control2: CGPoint(
                    x: rect.minX + 5 * rect.width / 6.0,
                    y: rect.minY + 12.5 * rect.height / 24.0))
            path.addLine(to: CGPoint(
                x: rect.minX + rect.width / 3.0,
                y: rect.minY + 13 * rect.height / 24.0))
            path.addCurve(
                to: CGPoint(
                    x: rect.minX + rect.width / 3.0,
                    y: rect.minY + 14.4 * rect.height / 24.0),
                control1: CGPoint(
                    x: rect.minX + 5 * rect.width / 6.0,
                    y: rect.minY + 11 * rect.height / 24.0),
                control2: CGPoint(
                    x: rect.minX + 5 * rect.width / 6.0,
                    y: rect.minY + 18 * rect.height / 24.0))
            path.addLine(to: CGPoint(
                x: rect.minX + rect.width / 6.0,
                y: rect.minY + 14.4 * rect.height / 24.0))
            path.addCurve(
                to: CGPoint(
                    x: rect.minX + 2 * rect.width / 3.0,
                    y: rect.minY + rect.height / 2.0),
                control1: CGPoint(
                    x: rect.minX + 5 * rect.width / 6.0,
                    y: rect.minY + 21.0 * rect.height / 24.0),
                control2: CGPoint(
                    x: rect.minX + 5.5 * rect.width / 6.0,
                    y: rect.minY + 27 * rect.height / 48.0))
            path.addCurve(
                to: CGPoint(
                    x: rect.minX + rect.width / 6.0,
                    y: rect.minY + 2.4 * rect.height / 6.0),
                control1: CGPoint(
                    x: rect.minX + 6 * rect.width / 6.0,
                    y: rect.minY + 21 * rect.height / 48.0),
                control2: CGPoint(
                    x: rect.minX + 3.75 * rect.width / 6.0,
                    y: rect.minY + 3.5 * rect.height / 24.0))
            path.closeSubpath()
        }
    }
}

#Preview {
    ThreeShape()
        .stroke(lineWidth: 2)
}
