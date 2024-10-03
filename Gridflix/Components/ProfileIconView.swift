//
//  ProfileIconView.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 12/09/24.
//

import SwiftUI

struct ProfileIconView: View {
    let backgroundColor: UIColor
    var body: some View {
        ProfileShape()
            .background(Color(uiColor: backgroundColor))
    }
}

extension ProfileIconView: Hashable {
    func hash(into hasher: inout Hasher) {
        if let components = backgroundColor.cgColor.components {
            for component in components {
                hasher.combine(component)
            }
        } else {
            hasher.combine(backgroundColor)
        }
    }
}

#Preview("SwiftUI") {
    VStack {
        HStack {
            ProfileIconView(backgroundColor: .systemRed)
                .frame(width: 100, height: 100, alignment: .center)
            ProfileIconView(backgroundColor: .systemYellow)
                .frame(width: 100, height: 100, alignment: .center)
        }
        HStack {
            ProfileIconView(backgroundColor: .systemGreen)
                .frame(width: 100, height: 100, alignment: .center)
            ProfileIconView(backgroundColor: .systemBlue)
                .frame(width: 100, height: 100, alignment: .center)
        }
    }
}

@available(iOS 17, *)
#Preview("UIKit") {
    let swiftUIViews = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemYellow, UIColor.systemGreen].map { uiColor in
        ProfileIconView(backgroundColor: uiColor)
            .frame(width: 100, height: 100, alignment: .center)
    }
    let swiftUIView = ProfileIconView(backgroundColor: .systemRed)
        .frame(width: 100, height: 100, alignment: .center)
    let hostingController = UIHostingController(rootView: swiftUIView)
    let hostingControllers = swiftUIViews.map { view in
        let hc = UIHostingController(rootView: view)
        hc.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return hc
    }
    hostingController.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    // Collection View
    
    let nc = UINavigationController(rootViewController: hostingController)
    nc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    nc.view.backgroundColor = .systemBlue
    return nc
}

final class GridCollectionViewController<Content: View>: NiblessViewController {
    let elements: [UIHostingController<Content>]
    let collectionView: UICollectionView

    init(elements: [Content]) {
        self.elements = elements.map { content in
            UIHostingController(rootView: content)
        }
        collectionView = UICollectionView()
        super.init()
        self.view = collectionView
    }

    override func viewDidLoad() {
        
    }
}

