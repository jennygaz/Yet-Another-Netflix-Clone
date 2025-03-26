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
                
                x: rect.midX - rect.width / 6.0,
                y: rect.minY + 3 * rect.height / 5.0))
            path.addLine(to: CGPoint(
                x: rect.midX,
                y: rect.minY + 3 * rect.height / 5.0))
            path.addCurve(
                to: CGPoint(
                    x: rect.midX,
                    y: rect.minY + 153 * rect.height / 240.0),
                control1: CGPoint(
                    x: rect.midX + 1.5 * rect.width / 6.0,
                    y: rect.minY + 9 * rect.height / 20.0),
                control2: CGPoint(
                    x: rect.midX + 3 * rect.width / 6.0,
                    y: rect.minY + 163 * rect.height / 240.0))
            path.addLine(to: CGPoint(
                x: rect.midX,
                y: rect.minY + 89 * rect.height / 120.0))
            path.addCurve(
                to: CGPoint(
                    x: rect.midX,
                    y: rect.minY + 96 * rect.height / 120.0),
                control1: CGPoint(
                    x: rect.midX + 3 * rect.width / 6.0,
                    y: rect.minY + 79 * rect.height / 120.0),
                control2: CGPoint(
                    x: rect.midX + 1.5 * rect.width / 6.0,
                    y: rect.minY + 114 * rect.height / 120.0))
            path.addLine(to: CGPoint(
                x: rect.midX - rect.width / 6.0,
                y: rect.minY + 96 * rect.height / 120.0))
            path.addCurve(
                to: CGPoint(
                    x: rect.midX + 1.6 * rect.width / 6.0,
                    y: rect.minY + 7 * rect.height / 10.0),
                control1: CGPoint(
                    x: rect.minX + 4.5 * rect.width / 6.0,
                    y: rect.minY + 131 * rect.height / 120.0),
                control2: CGPoint(
                    x: rect.minX + 7 * rect.width / 6.0,
                    y: rect.minY + 168 * rect.height / 240.0))
            path.addCurve(
                to: CGPoint(
                    x: rect.midX - rect.width / 6.0,
                    y: rect.minY + 3.6 * rect.height / 6.0),
                control1: CGPoint(
                    x: rect.minX + 7 * rect.width / 6.0,
                    y: rect.minY + 73 * rect.height / 120.0),
                control2: CGPoint(
                    x: rect.minX + 4.5 * rect.width / 6.0,
                    y: rect.minY + 83 * rect.height / 240.0))
            path.closeSubpath()
        }
    }
}

#Preview {
    ThreeShape()
        .stroke(lineWidth: 2)
}
