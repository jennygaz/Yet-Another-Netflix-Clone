//
//  RankedTitleCellView.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 11/11/24.
//

import SwiftUI

struct RankedTitleCellView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                HStack(alignment: .bottom, spacing: 0) {
                    TwoShape().stroke(lineWidth: 4.0)
                        .frame(
                            width: proxy.frame(in: .global).width * 4 / 10,
                            height: proxy.frame(in: .global).height / 2)
                        .offset(x: 50, y: 80)
                        .foregroundStyle(Color.white)
                    Image("naruto_hero_view")
                        .resizable()
                        .frame(height: proxy.frame(in: .global).height / 2)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .overlay(alignment: .center) {
                            RoundedRectangle(cornerRadius: 8.0)
                                .stroke(lineWidth: 2.0)
                                .foregroundColor(.white)
                        }
                }
                .padding()
                .background(Color.black.opacity(0.85))
                Spacer()
            }
        }
    }
}

@available(iOS 17, *)
#Preview {
    RankedTitleCellView()
}
