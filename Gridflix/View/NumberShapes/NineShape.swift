//
//  NineShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 27/02/25.
//

import SwiftUI

struct NineShape: Shape {
    var rightPaddingPercentage: CGFloat = 0.1
    
    func path(in rect: CGRect) -> Path {
        let effectiveWidth = rect.width * (1.0 - rightPaddingPercentage)
        let heightScale: CGFloat = 0.9
        let yOffset = rect.height * (1.0 - heightScale) / 2
        
        return Path { path in
            // Top circle
            path.addArc(
                center: CGPoint(
                    x: rect.minX + effectiveWidth / 2.0,
                    y: yOffset + rect.height * heightScale * 6.0 / 18.0),
                radius: effectiveWidth / 4.0,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: false)
            
            // Vertical line on right
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth * 3.0 / 4.0,
                y: yOffset + rect.height * heightScale * 6.0 / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth * 3.0 / 4.0,
                y: yOffset + rect.height * heightScale * 14.0 / 18.0))
            
            // Bottom curve
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth * 3.0 / 4.0,
                y: yOffset + rect.height * heightScale * 14.0 / 18.0))
            path.addCurve(
                to: CGPoint(
                    x: rect.minX + effectiveWidth / 4.0,
                    y: yOffset + rect.height * heightScale * 12.0 / 18.0),
                control1: CGPoint(
                    x: rect.minX + effectiveWidth * 3.0 / 4.0,
                    y: yOffset + rect.height * heightScale * 16.0 / 18.0),
                control2: CGPoint(
                    x: rect.minX + effectiveWidth / 3.0,
                    y: yOffset + rect.height * heightScale * 15.0 / 18.0))
        }
    }
}

#Preview {
    NineShape()
        .stroke(lineWidth: 2)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.1))
}
