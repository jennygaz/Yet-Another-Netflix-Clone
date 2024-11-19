//
//  HeroHeaderViewSwiftUI.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 06/10/24.
//

import SwiftUI

struct MovieData {
    let movieName: String
    let imageURL: String
    let logoURL: String
    var categories: [HomeFilter.Category]
    let descriptors: [MovieDescriptor]
    var isListed: Bool {
        categories.contains { $0 == .myList }
    }
}

struct HeroHeaderViewSwiftUI: View {
    @State private var currentFilter: HomeFilter? = nil
    @State private var category: HomeFilter.Category = .home
    @State private var isCategoryPickerOpen: Bool = false
    @Binding var movieData: MovieData

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                closeFiltersButton
                ForEach(HomeFilter.allCases) { filter in
                    conditionalFilter(for: filter)
                }
                categoryButton
            }
            .padding(.horizontal, 8)
            .tint(.white.opacity(0.5))
            .foregroundColor(.white)
            .font(.subheadline)
            heroBanner
        }
        .background(Color.black.opacity(0.925)) // Extract
        .fullScreenCover(isPresented: $isCategoryPickerOpen) {
            FullScreenWheelPicker(
                selection: $category,
                values: HomeFilter.Category.allCases) {
                    isCategoryPickerOpen = false
                    if category != .home {
                        currentFilter = .categories(category)
                    }
                    if category == .myList {
                        print("Accessing your list...")
                    }
                } dismissAction: {
                    isCategoryPickerOpen = false
                }
        }
    }

    @ViewBuilder
    private var closeFiltersButton: some View {
        if currentFilter != nil {
            Button {
                withAnimation(.easeIn) {
                    currentFilter = nil
                    if category != .home {
                        category = .home
                    }
                }
            } label: {
                Image("custom.x")
                    .padding(5)
                    .background(FilterButtonBackground(isPressed: false))
            }
            .transition(.move(edge: .leading).combined(with: .opacity))
        }
    }

    @ViewBuilder
    private var categoryButton: some View {
        let isDisplayed: Bool = currentFilter == nil || (currentFilter != .movies && currentFilter != .tvShows && currentFilter != .categories(.home))
        if isDisplayed {
            Button {
                guard currentFilter == nil else { return }
                withAnimation(.easeOut) {
                    isCategoryPickerOpen = true
                }
            } label: {
                Label(category == .home ? "Categories" : category.description, systemImage: "chevron.down")
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(FilterButtonBackground(isPressed: (
                        currentFilter != .categories(.home)
                        && currentFilter != .movies
                        && currentFilter != .tvShows
                        && currentFilter != nil)))
            }
            .transition(.move(edge: .leading).combined(with: .opacity))
        }
    }

    @ViewBuilder
    private func conditionalFilter(for filter: HomeFilter) -> some View {
        if currentFilter == nil || currentFilter == filter {
            Button {
                guard currentFilter == nil else { return }
                withAnimation(.easeOut) {
                    currentFilter = filter
                }
            } label: {
                Text(filter.description)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(FilterButtonBackground(isPressed: currentFilter == filter))
            }
            .transition(.move(edge: .leading).combined(with: .opacity))
        }
    }

    @ViewBuilder
    private var heroBannerBackground: some View {
        ZStack(alignment: .center) {
            Image("naruto_hero_view")
                .resizable()
                .clipShape(.rect(cornerRadius: 24.0), style: FillStyle(eoFill: true, antialiased: true))
            
            RoundedRectangle(cornerRadius: 24.0)
                .stroke(lineWidth: 2.0)
                .fill(Material.thin)
            
            LinearGradient(
                stops: [
                    .init(color: Color.clear, location: 0.0),
                    .init(color: Color.white.opacity(0.4), location: 0.7),
                    .init(color: Color.black.opacity(0.4), location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom)
            .border(.thinMaterial.opacity(0.6).blendMode(.hardLight), width: 2.0)
            .clipShape(.rect(cornerRadius: 24.0), style: FillStyle(eoFill: true, antialiased: true))
            .shadow(color: .white.opacity(0.4), radius: 5)
            
        }
        .padding(20)
    }

    @ViewBuilder
    private func bannerLogo(proxy: GeometryProxy) -> some View {
        Image(movieData.logoURL)
            .resizable()
            .frame(width: proxy.frame(in: .global).width * 0.6, height: proxy.frame(in: .global).height * 0.15, alignment: .bottom)
    }

    @ViewBuilder
    private var descriptorsContainer: some View {
        HStack(spacing: 6) {
            ForEach(movieData.descriptors, id: \.rawValue) { descriptor in
                Text(descriptor.rawValue)
                if descriptor != movieData.descriptors.last {
                    Image("custom.dot")
                }
            }
        }
        .font(.caption2)
        .foregroundColor(.white)
        .padding(.horizontal, 10)
    }

    @ViewBuilder
    private var bannerControls: some View {
        HStack(spacing: 12) {
            Button {
                print("Play")
            } label: {
                Label("Play", systemImage: "play.fill")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.black)
            }
            .buttonStyle(.borderedProminent)
            .tint(.white)
            Button {
                print("My List")
                withAnimation(.interactiveSpring(duration: 0.5)) {
                    if movieData.isListed {
                        movieData.categories.removeAll { $0 == .myList }
                    } else {
                        movieData.categories.append(.myList)
                    }
                }
            } label: {
                Label(
                    "My List",
                    systemImage: movieData.isListed
                        ? "checkmark"
                        : "plus")
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
            }
            .buttonStyle(.borderless)
            .tint(.gray)
            .buttonBorderShape(.roundedRectangle)
            .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1.0).fill(Color.white))
        }
        .font(.title2)
        .padding(.horizontal, 30)
    }

    @ViewBuilder
    private var heroBanner: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                heroBannerBackground
                    .onTapGesture {
                        print(movieData.movieName)
                    }
                VStack(spacing: 20) {
                    Spacer()
                    bannerLogo(proxy: proxy)
                    descriptorsContainer
                    bannerControls
                }
                .padding(.bottom, 40)
            }
        }
    }
}

@available(iOS 17, *)
#Preview {
    @Previewable @State var movieData: MovieData = .init(
        movieName: "Naruto Shippuden",
        imageURL: "naruto_hero_view",
        logoURL: "naruto_logo",
        categories: [
            .action,
            .anime,
            .comedies,
            .downloadable,
            .fantasy,
            .myList
        ],
        descriptors: [
            .goofy,
            .action,
            .heroJourney,
            .anime,
            .growth
        ])
    HeroHeaderViewSwiftUI(movieData: $movieData)
}
