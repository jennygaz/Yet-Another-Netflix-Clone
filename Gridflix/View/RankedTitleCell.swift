//
//  RankedTitleCell.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 08/11/24.
//

import UIKit
import SwiftUI

enum Rank: Int {
    case one = 1, two, three, four, five, six, seven, eight, nine, ten
}

struct RankedTitle {
    let imageName: String
    let rankNumber: Rank
}

final class RankedTitleCell: UICollectionViewCell {
    static let identifier: String = "RankedTitleCell"

    // MARK: - Properties
    private var model: RankedTitle = .init(imageName: "naruto_hero_view", rankNumber: .one)
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var shapeLayer: CAShapeLayer = .init()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        configure(with: model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func configure(with model: RankedTitle) {
        let image = UIImage(named: model.imageName)
        imageView.image = image
//        imageView.layer.borderColor = UIColor.white.darker().darker().cgColor
//        imageView.layer.borderWidth = 2.0
        shapeLayer.removeFromSuperlayer()
        self.shapeLayer = makeShapeLayer()
        self.layer.addSublayer(shapeLayer)
    }

    // MARK: - Private Methods
    private func makeShapeLayer() -> CAShapeLayer {
        
        let shapeLayer = CAShapeLayer()
//        let imageRect = imageView.bounds
//        let rect = CGRect(
//            x: 0,
//            y: 0,
//            width: 200,
//            height: 350)
        shapeLayer.path = CustomShapes.makeBezierPathFor(rank: model.rankNumber, in: self.bounds)
//        print("Rects:\nbounds:")
//        print(self.bounds)
//        print("rect:")
//        print(rect)
//        print("----")
//        print(CustomShapes.makeBezierPathFor(rank: .one, in: rect))
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.position = CGPoint(x: 75, y: 180)
        shapeLayer.zPosition = -1
        self.bringSubviewToFront(imageView)
        return shapeLayer
    }

    private func setupHierarchy() {
        addSubview(imageView)
        self.layer.addSublayer(shapeLayer)
    }

    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

struct CustomShapes {
    static func makeBezierPathFor(rank: Rank, in rect: CGRect) -> CGPath {
        switch rank {
        case .one:
            return OneShape().path(in: rect).cgPath
        default: return CGPath(rect: .zero, transform: nil)
        }
        
    }
}

@available(iOS 17, *)
#Preview("RankedTitleCell") {
    let cell = RankedTitleCell(frame: CGRect(x: 0, y: 0, width: 150, height: 250))
    cell.backgroundColor = .black
//    cell.layer.borderWidth = 2.0
//    cell.layer.borderColor = UIColor.cyan.cgColor
    let vc = UIViewController(nibName: nil, bundle: nil)
    vc.view = cell
    return vc
}
