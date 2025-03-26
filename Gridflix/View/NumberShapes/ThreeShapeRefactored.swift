//
//  ThreeShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 27/02/25.
//

import SwiftUI

struct ThreeShapeRefactored: Shape {
    var rightPaddingPercentage: CGFloat = 0.1
    
    func path(in rect: CGRect) -> Path {
        let effectiveWidth = rect.width * (1.0 - rightPaddingPercentage)
        let heightScale: CGFloat = 0.9
        let yOffset = rect.height * (1.0 - heightScale) / 2
        
        return Path { path in
            // Top arc
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth / 6.0,
                y: yOffset + 7.0 * rect.height * heightScale / 18.0))
            
            path.addArc(
                center: CGPoint(
                    x: rect.minX + effectiveWidth / 2.0,
                    y: yOffset + rect.height * heightScale * 7.0 / 18.0),
                radius: effectiveWidth / 3.0,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 0),
                clockwise: false)
            
            // Middle connecting line
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth * 5.0 / 6.0,
                y: yOffset + rect.height * heightScale * 7.0 / 18.0))
            
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth * 2.0 / 3.0,
                y: yOffset + rect.height * heightScale * 9.0 / 18.0))
                
            // Bottom arc
            path.addArc(
                center: CGPoint(
                    x: rect.minX + effectiveWidth / 2.0,
                    y: yOffset + rect.height * heightScale * 11.0 / 18.0),
                radius: effectiveWidth / 3.0,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false)
                
            // Final line to close the shape
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth / 6.0,
                y: yOffset + rect.height * heightScale * 11.0 / 18.0))
                
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth / 3.0,
                y: yOffset + rect.height * heightScale * 11.0 / 18.0))
        }
    }
}

#Preview {
    ThreeShapeRefactored()
        .stroke(lineWidth: 2)
}
