//
//  FullscreenWheelPicker.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 08/10/24.
//

import SwiftUI

final class WheelPickerModel: ObservableObject {
    @Published var selection: HomeFilter.Category = .home
}
struct FullScreenWheelPicker<Value: Hashable & CustomStringConvertible>: View {
    var title: String?
    @Binding var selection: Value
    var values: [Value]
    var selectAction: (() -> Void)?
    var dismissAction: (() -> Void)?

    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                LazyVStack(alignment: .center, spacing: 32, pinnedViews: .sectionFooters) {
                    Section {
                        ForEach(values, id: \.hashValue) { value in
                            Button {
                                withAnimation(.easeInOut) {
                                    selection = value
                                }
                                selectAction?()
                            } label: {
                                Text(value.description)
                                    .font(
                                        selection == value
                                        ? .title.bold()
                                        : .title)
                                    .scaleEffect(
                                        x: selection == value ? 1.25 : 1.0,
                                        y: selection == value ? 1.25 : 1.0,
                                        anchor: .center)
                            }
                            .tint(.white.opacity(0.75))
                        }
                    } footer: {
                        VStack(alignment: .center) {
                            Spacer(minLength: proxy.frame(in: .global).height * 0.045)
                            Button {
                                dismissAction?()
                            } label: {
                                Image("custom.x")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.white)
                            .foregroundColor(.black)
                            .clipShape(Circle())
                            .frame(maxHeight: proxy.frame(in: .global).height * 0.09)
                            Spacer(minLength: proxy.frame(in: .global).height * 0.045)
                        }
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                            colors: [
                                Color.black.opacity(0.2),
                                Color.black.opacity(0.75)
                            ],
                            startPoint: .top,
                            endPoint: .bottom)
                        )
                    }
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
        .background(Color.black)
    }
}

@available(iOS 17, *)
#Preview {
    @Previewable @StateObject var observed = WheelPickerModel()
    FullScreenWheelPicker(selection: $observed.selection, values: HomeFilter.Category.allCases) {
        
    } dismissAction: {
        
    }
}
