//
//  TwoShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 08/11/24.
//

import SwiftUI

struct TwoShapeRefactored: Shape {
    // Amount of right padding as a percentage of total width
    var rightPaddingPercentage: CGFloat = 0.1
    
    func path(in rect: CGRect) -> Path {
        // Calculate effective width to leave padding on the right
        let effectiveWidth = rect.width * (1.0 - rightPaddingPercentage)
        
        // Scale the shape to fill most of the height
        let heightScale: CGFloat = 0.9
        let yOffset = rect.height * (1.0 - heightScale) / 2
        
        return Path { path in
            // Start position adjusted to fill the screen
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth / 6.0,
                y: yOffset + 7.0 * rect.height * heightScale / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth / 3.0,
                y: yOffset + 7.0 * rect.height * heightScale / 18.0))
            
            path.addArc(
                center: CGPoint(
                    x: rect.minX + effectiveWidth / 2.0,
                    y: yOffset + rect.height * heightScale * 7.0 / 18.0),
                radius: effectiveWidth / 6.0,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 15),
                clockwise: false)
            
            // Flat 2 - all coordinates adjusted to use effective width
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth / 6.0,
                y: yOffset + 13.0 * rect.height * heightScale / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth / 6.0,
                y: yOffset + 13.0 * rect.height * heightScale / 18.0 + effectiveWidth / 6.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth * 5.0 / 6.0,
                y: yOffset + rect.height * heightScale * 13.0 / 18.0 + effectiveWidth / 6.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth * 5.0 / 6.0,
                y: yOffset + rect.height * heightScale * 13.0 / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth * 5.0 / 12.0,
                y: yOffset + rect.height * heightScale * 13.0 / 18.0))
            
            // Flat 2 continued
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth / 3.0 * cos(.pi / 12) + effectiveWidth / 2.0,
                y: yOffset + rect.height * heightScale * sin(.pi / 12) + effectiveWidth / 3.0))
            path.addArc(
                center: CGPoint(
                    x: rect.minX + effectiveWidth / 2.0,
                    y: yOffset + rect.height * heightScale * 7.0 / 18.0),
                radius: effectiveWidth / 3.0,
                startAngle: Angle(degrees: 14),
                endAngle: Angle(degrees: 180),
                clockwise: true)
        }
    }
}

#Preview {
    TwoShapeRefactored()
        .stroke(lineWidth: 2)
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        .background(Color.black.opacity(0.1))
}
