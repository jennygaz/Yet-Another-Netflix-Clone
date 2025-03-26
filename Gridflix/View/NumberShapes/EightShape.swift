//
//  EightShape.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 27/02/25.
//

import SwiftUI

struct EightShape: Shape {
    var rightPaddingPercentage: CGFloat = 0.1
    
    func path(in rect: CGRect) -> Path {
        let effectiveWidth = rect.width * (1.0 - rightPaddingPercentage)
        let heightScale: CGFloat = 0.9
        let yOffset = rect.height * (1.0 - heightScale) / 2
        
        return Path { path in
            // Top circle
            path.addEllipse(in: CGRect(
                x: rect.minX + effectiveWidth / 4.0,
                y: yOffset + rect.height * heightScale * 4.0 / 18.0,
                width: effectiveWidth / 2.0,
                height: effectiveWidth / 2.0))
            
            // Bottom circle
            path.addEllipse(in: CGRect(
                x: rect.minX + effectiveWidth / 4.0,
                y: yOffset + rect.height * heightScale * 9.0 / 18.0,
                width: effectiveWidth / 2.0,
                height: effectiveWidth / 2.0))
        }
    }
}

#Preview {
    EightShape()
        .stroke(lineWidth: 2)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.1))
}
