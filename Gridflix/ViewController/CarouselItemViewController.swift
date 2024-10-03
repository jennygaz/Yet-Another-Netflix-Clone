//
//  CarouselItemViewController.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 26/09/24.
//

import UIKit

class CarouselItemViewController: UIViewController {
    // MARK: - Properties
    private let photo: String
    private let text: String

    // MARK: - Lifetime
    init(photo: String, text: String) {
        self.photo = photo
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = CarouselItemView(frame: self.view.frame, imageName: photo, text: text)
    }
}

@available(iOS 17, *)
#Preview("Carousel Item VC") {
    let vc = UIViewController()
    return vc
}
