//
//  FilterButton.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 18/10/24.
//
import SwiftUI

struct FilterButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    Capsule().stroke(lineWidth: 1.0).fill(
                        configuration.isPressed
                        ? Color.white.opacity(0.325)
                        : Color.white
                    )
                    Capsule().fill(
                        configuration.isPressed
                        ? Color.white.opacity(0.325)
                        : Color.clear
                    )
                }
            )
            .foregroundColor(Color.white)
            .animation(.interactiveSpring(duration: 0.2), value: configuration.isPressed)
    }
}

struct FilterButtonBackground: View {
    var isPressed: Bool
    var body: some View {
        ZStack {
            Capsule().stroke(lineWidth: 1.0).fill(
                isPressed
                ? Color.white.opacity(0.325)
                : Color.white
            )
            Capsule().fill(
                isPressed
                ? Color.white.opacity(0.325)
                : Color.clear
            )
        }
        .foregroundColor(Color.white)
        .animation(.interactiveSpring(duration: 0.2), value: isPressed)
    }
}
