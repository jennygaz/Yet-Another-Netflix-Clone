//
//  FiveShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 27/02/25.
//

import SwiftUI

struct FiveShape: Shape {
    var rightPaddingPercentage: CGFloat = 0.1
    
    func path(in rect: CGRect) -> Path {
        let effectiveWidth = rect.width * (1.0 - rightPaddingPercentage)
        let heightScale: CGFloat = 0.9
        let yOffset = rect.height * (1.0 - heightScale) / 2
        
        return Path { path in
            // Top horizontal line
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth / 4.0,
                y: yOffset + rect.height * heightScale * 3.0 / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth * 3.0 / 4.0,
                y: yOffset + rect.height * heightScale * 3.0 / 18.0))
            
            // Vertical line from top
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth / 4.0,
                y: yOffset + rect.height * heightScale * 3.0 / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth / 4.0,
                y: yOffset + rect.height * heightScale * 9.0 / 18.0))
            
            // Middle horizontal line
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth * 2.0 / 3.0,
                y: yOffset + rect.height * heightScale * 9.0 / 18.0))
            
            // Bottom arc
            path.addArc(
                center: CGPoint(
                    x: rect.minX + effectiveWidth / 2.0,
                    y: yOffset + rect.height * heightScale * 12.0 / 18.0),
                radius: effectiveWidth / 3.0,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false)
                
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth / 4.0,
                y: yOffset + rect.height * heightScale * 12.0 / 18.0))
        }
    }
}

#Preview {
    FiveShape()
        .stroke(lineWidth: 2)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.1))
}
