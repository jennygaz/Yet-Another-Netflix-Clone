//
//  SevenShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 27/02/25.
//

import SwiftUI

struct SevenShape: Shape {
    var rightPaddingPercentage: CGFloat = 0.1
    
    func path(in rect: CGRect) -> Path {
        let effectiveWidth = rect.width * (1.0 - rightPaddingPercentage)
        let heightScale: CGFloat = 0.9
        let yOffset = rect.height * (1.0 - heightScale) / 2
        
        return Path { path in
            // Top horizontal line
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth / 4.0,
                y: yOffset + rect.height * heightScale * 4.0 / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth * 3.0 / 4.0,
                y: yOffset + rect.height * heightScale * 4.0 / 18.0))
            
            // Diagonal line
            path.move(to: CGPoint(
                x: rect.minX + effectiveWidth * 3.0 / 4.0,
                y: yOffset + rect.height * heightScale * 4.0 / 18.0))
            path.addLine(to: CGPoint(
                x: rect.minX + effectiveWidth / 3.0,
                y: yOffset + rect.height * heightScale * 14.0 / 18.0))
        }
    }
}

#Preview {
    SevenShape()
        .stroke(lineWidth: 2)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.1))
}
