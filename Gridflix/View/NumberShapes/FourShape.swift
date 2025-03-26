//
//  FourShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 26/02/25.
//

import SwiftUI

struct FourShape: Shape {
    var rightPaddingPercentage: CGFloat = 0.1
    
    func path(in rect: CGRect) -> Path {
        let effectiveWidth = rect.width * (1.0 - rightPaddingPercentage)
        let heightScale: CGFloat = 0.9
        let yOffset = rect.height * (1.0 - heightScale) / 2
        
        return Path { path in
            // Vertical line on right
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth * 3.0 / 4.0,
                y: yOffset + rect.height * heightScale * 3.0 / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth * 3.0 / 4.0,
                y: yOffset + rect.height * heightScale * 15.0 / 18.0))
            
            // Diagonal line
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth / 4.0,
                y: yOffset + rect.height * heightScale * 3.0 / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth * 3.0 / 4.0,
                y: yOffset + rect.height * heightScale * 9.0 / 18.0))
            
            // Horizontal line
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth / 4.0,
                y: yOffset + rect.height * heightScale * 9.0 / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth * 4.0 / 5.0,
                y: yOffset + rect.height * heightScale * 9.0 / 18.0))
        }
    }
}

#Preview {
    FourShape()
        .stroke(lineWidth: 2)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.1))
}
