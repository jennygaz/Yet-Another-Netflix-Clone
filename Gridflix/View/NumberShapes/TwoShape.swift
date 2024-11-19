//
//  TwoShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 08/11/24.
//

import SwiftUI

struct TwoShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(
                x: rect.minX + rect.width / 6.0,
                y: rect.minY + 7.0 * rect.height / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + rect.width / 3.0,
                y: rect.minY + 7.0 * rect.height / 18.0))
//            path.move(to: CGPoint(
//                x: rect.width / 2.0,
//                y: rect.height * 7.0 / 18.0))
            path.addArc(
                center: CGPoint(
                    x: rect.minX + rect.width / 2.0,
                    y: rect.minY + rect.height * 7.0 / 18.0),
                radius: rect.width / 6.0,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 15),
                clockwise: false)
            // Curved 2
//            path.addCurve(
//                to: CGPoint(
//                    x: rect.minX + rect.width / 6.0,
//                    y: rect.minY + 17.0 * rect.height / 18.0),
//                control1: CGPoint(
//                    x: rect.minX + rect.width * 7.0 / 12.0,
//                    y: rect.minY + 23.0 * rect.height / 36.0),
//                control2: CGPoint(
//                    x: rect.minX + rect.width * 4.0 / 18.0,
//                    y: rect.minY + rect.height * 23.0 / 36.0))
            // End Curved 2
            // Flat 2
            path.addLine(to: CGPoint(
                x: rect.minX + rect.width / 6.0,
                y: rect.minY + 13.0 * rect.height / 18.0))
            path .addLine(to: CGPoint(
                x: rect.minX + rect.width / 6.0,
                y: rect.minY + 13.0 * rect.height / 18.0 + rect.width / 6.0))
            path.addLine(to: CGPoint(
                x: rect.minX + rect.width * 5.0 / 6.0,
                y: rect.minY + rect.height * 13.0 / 18.0 + rect.width / 6.0))
            path.addLine(to: CGPoint(
                x: rect.minX + rect.width * 5.0 / 6.0,
                y: rect.minY + rect.height * 13.0 / 18.0 + rect.width / 6.0))
            path.addLine(to: CGPoint(
                x: rect.minX + rect.width * 5.0 / 6.0,
                y: rect.minY + rect.height * 13.0 / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + rect.width * 5.0 / 12.0,
                y: rect.minY + rect.height * 13.0 / 18.0))
            // Curved 2
//            path.addCurve(
//                to: CGPoint(
//                    x: rect.minX + rect.width / 3.0 * cos(.pi / 12) + rect.width / 2.0,
//                    y: rect.minY + rect.height * sin(.pi / 12)/*rect.height * 7.0 / 18.0*/ + rect.width / 3.0),
//                control1: CGPoint(
//                    x: rect.minX + rect.width / 2.0,
//                    y: rect.minY + rect.height * 23.0 / 36.0),
//                control2: CGPoint(
//                    x: rect.minX + rect.width * 9.0 / 12.0,
//                    y: rect.minY + rect.height * 23.0 / 36.0))
            // End Curved 2
            // Flat 2
            path.addLine(to: CGPoint(
                x: rect.minX + rect.width / 3.0 * cos(.pi / 12) + rect.width / 2.0,
                y: rect.minY + rect.height * sin(.pi / 12) + rect.width / 3.0))
            path.addArc(
                center: CGPoint(
                    x: rect.minX + rect.width / 2.0,
                    y: rect.minY + rect.height * 7.0 / 18.0),
                radius: rect.width / 3.0,
                startAngle: Angle(degrees: 14),
                endAngle: Angle(degrees: 180),
                clockwise: true)
            
        }
    }
}

#Preview {
    TwoShape()
        .stroke(lineWidth: 2)
}
