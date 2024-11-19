//
//  RankedTitleCell.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 08/11/24.
//

import UIKit
import SwiftUI

enum Rank: Int {
    case zero = 0
    case one, two, three, four, five, six, seven, eight, nine
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
        imageView.layer.borderColor = UIColor.green.cgColor
        imageView.layer.borderWidth = 2.0
        shapeLayer.removeFromSuperlayer()
        self.shapeLayer = makeShapeLayer()
        self.layer.addSublayer(shapeLayer)
    }

    // MARK: - Private Methods
    private func makeShapeLayer() -> CAShapeLayer {
        
        let shapeLayer = CAShapeLayer()
        let imageRect = imageView.bounds
        let rect = CGRect(
            x: imageRect.minX - 100,
            y: imageRect.minY,
            width: 100,
            height: imageRect.height)
        shapeLayer.path = CustomShapes.makeBezierPathFor(rank: model.rankNumber, in: self.bounds)
        print(CustomShapes.makeBezierPathFor(rank: .one, in: rect))
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.position = CGPoint(x: 100, y: 100)
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
            let m = -30.0 * rect.height / (144.0 * rect.width)// (5.0 * rect.height / 12.0) / (rect.width / 15.0)
            let b = 41.0 * rect.height / 144.0// 21.0 * rect.height / 26.0
            let path = Path { path in
                path.move(to: CGPoint(
                    x: rect.midX,
                    y: rect.minY + rect.height / 6.0 + rect.height - rect.height / 6.0 * 5))
                path.addLine(to: CGPoint(
                    x: rect.midX - rect.width / 3.0,
                    y: rect.minY + rect.height / 4.0 + rect.height - rect.height / 6.0 * 5))
                path.addLine(to: CGPoint(
                    x: rect.midX - rect.width / 3.0,
                    y: rect.minY + rect.height / 3.0 + rect.height - rect.height / 6.0 * 5))
                path.addLine(to: CGPoint(
                    x: rect.midX - rect.width / 10.0,
                    y: m * (rect.width / 10.0) + b + rect.height - rect.height / 6.0 * 5))
                
                path.addLine(to: CGPoint(
                    x: rect.midX - rect.width / 10.0,
                    y: rect.minY + rect.height))
                path.addLine(to: CGPoint(
                    x: rect.midX + rect.width / 10.0,
                    y: rect.minY + rect.height))
                path.addLine(to: CGPoint(
                    x: rect.midX + rect.width / 10.0,
                    y: rect.minY + rect.height / 7.0 + rect.height - rect.height / 6.0 * 5))
                path.closeSubpath()
            }
            return path.cgPath
        default: return CGPath(rect: .zero, transform: nil)
        }
        
    }
}

@available(iOS 17, *)
#Preview("RankedTitleCell") {
    let cell = RankedTitleCell(frame: CGRect(x: 50, y: 50, width: 100, height: 200))
    cell.backgroundColor = .black
    let vc = UIViewController(nibName: nil, bundle: nil)
    vc.view = cell
    return vc
}
