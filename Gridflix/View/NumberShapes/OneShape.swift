//
//  OneShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 08/11/24.
//

import SwiftUI

struct OneShape: Shape {
    func path(in rect: CGRect) -> Path {
        let m = -30.0 * rect.height / (144.0 * rect.width)// (5.0 * rect.height / 12.0) / (rect.width / 15.0)
        let b = 41.0 * rect.height / 144.0// 21.0 * rect.height / 26.0
        return Path { path in
            path.move(to: CGPoint(
                x: rect.midX,
                y: rect.minY + rect.height / 6.0 + rect.height - rect.height / 6.0 * 5))
            path.addLine(to: CGPoint(
                x: rect.midX - rect.width / 3.0,
                y: rect.minY + rect.height / 4.0 + rect.height - rect.height / 6.0 * 5))
            path.addLine(to: CGPoint(
                x: rect.midX - rect.width / 3.0,
                y: rect.minY + rect.height / 3.0 + rect.height - rect.height / 6.0 * 5))
            path.addLine(to: CGPoint(
                x: rect.midX - rect.width / 10.0,
                y: m * (rect.width / 10.0) + b + rect.height - rect.height / 6.0 * 5))
            
            path.addLine(to: CGPoint(
                x: rect.midX - rect.width / 10.0,
                y: rect.minY + rect.height))
            path.addLine(to: CGPoint(
                x: rect.midX + rect.width / 10.0,
                y: rect.minY + rect.height))
            path.addLine(to: CGPoint(
                x: rect.midX + rect.width / 10.0,
                y: rect.minY + rect.height / 7.0 + rect.height - rect.height / 6.0 * 5))
            path.closeSubpath()
        }
        /*
         return Path { path in
             path.move(to: CGPoint(
                 x: rect.midX,
                 y: rect.minY + rect.height / 6.0))
             path.addLine(to: CGPoint(
                 x: rect.midX - rect.width / 3.0,
                 y: rect.minY + rect.height / 4.0))
             path.addLine(to: CGPoint(
                 x: rect.midX - rect.width / 3.0,
                 y: rect.minY + rect.height / 3.0))
             path.addLine(to: CGPoint(
                 x: rect.midX - rect.width / 10.0,
                 y: m * (rect.width / 10.0) + b))
             path.addLine(to: CGPoint(
                 x: rect.midX - rect.width / 10.0,
                 y: rect.minY + rect.height / 6.0 * 5))
             path.addLine(to: CGPoint(
                 x: rect.midX + rect.width / 10.0,
                 y: rect.minY + rect.height / 6.0 * 5))
             path.addLine(to: CGPoint(
                 x: rect.midX + rect.width / 10.0,
                 y: rect.minY + rect.height / 7.0))
             path.closeSubpath()
         }
         */
    }
}

#Preview {
    OneShape()
        .stroke(lineWidth: 2.0)
}
