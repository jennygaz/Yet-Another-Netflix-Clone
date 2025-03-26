//
//  OneShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 08/11/24.
//

import SwiftUI

struct OneShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(
                x: rect.maxX,
                y: rect.midY * 1.0 / 4.5))
            path.addLine(to: CGPoint(
                x: rect.width * 0.3,
                y: rect.midY * 2.0 / 5.0))
            path.addLine(to: CGPoint(
                x: rect.width * 0.3,
                y: rect.midY * 3.0 / 4.0))
            path.addLine(to: CGPoint(
                x: rect.midX,
                y: rect.midY * 3.0 / 4.3))
            path.addLine(to: CGPoint(
                x: rect.midX,
                y: rect.height))
            path.addLine(to: CGPoint(
                x: rect.maxX,
                y: rect.maxY))
            path.addLine(to: CGPoint(
                x: rect.maxX,
                y: rect.midY / 4.0))
            path.closeSubpath()
        }
    }
}

#Preview {
    OneShape()
        .stroke(lineWidth: 2.0)
        .foregroundColor(.white)
        .background(Color.black)
}
