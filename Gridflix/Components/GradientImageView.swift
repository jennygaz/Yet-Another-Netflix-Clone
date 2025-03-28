//
//  UIImageView+Extension.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 02/10/24.
//

import UIKit

@MainActor
public class GradientImageView: UIImageView {
    // MARK: - Properties
    private(set) public var colors: [UIColor] = [] {
        didSet { updateGradient() }
    }

    private var cgColors: [CGColor] {
        return colors.map { $0.cgColor }
    }

    private var points: [UnitPoint] = [.top, .bottom] {
        didSet { updateGradient() }
    }

    private(set) public var stops: [Stop] = [] {
        didSet { updateGradient() }
    }
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.shouldRasterize = true
        return layer
    }()

    // MARK: - UI
    private lazy var overlayView: UIView = { return UIView() }()

    // MARK: - Constructor
    public init(image: UIImage?, colors: [UIColor], startPoint: UnitPoint = .top, endPoint: UnitPoint = .bottom) {
        super.init(image: image)
        self.colors = colors
        self.points = [startPoint, endPoint]
    }

    public init(image: UIImage?, stops: [Stop] = []) {
        super.init(image: image)
        self.colors = stops.map { UIColor(cgColor: $0.color) }
        self.stops = stops.filter { 0.0 <= $0.point.doubleValue && $0.point.doubleValue <= 1.0 }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Unit Point
public extension GradientImageView {
    @MainActor
    enum UnitPoint {
        case top
        case bottom
        case leading
        case trailing
        case topLeading
        case topTrailing
        case bottomLeading
        case bottomTrailing

        var point: CGPoint {
            switch self {
            case .top: CGPoint(x: 0.5, y: 0)
            case .bottom: CGPoint(x: 0.5, y: 1)
            case .leading:
                isLeftToRight()
                ? CGPoint(x: 0, y: 0.5)
                : CGPoint(x: 1, y: 0.5)
            case .trailing:
                isLeftToRight()
                ? CGPoint(x: 1, y: 0.5)
                : CGPoint(x: 0, y: 0.5)
            case .topLeading:
                isLeftToRight()
                ? CGPoint(x: 0, y: 0)
                : CGPoint(x: 1, y: 0)
            case .topTrailing:
                isLeftToRight()
                ? CGPoint(x: 1, y: 0)
                : CGPoint(x: 0, y: 0)
            case .bottomLeading:
                isLeftToRight()
                ? CGPoint(x: 0, y: 1)
                : CGPoint(x: 1, y: 1)
            case .bottomTrailing:
                isLeftToRight()
                ? CGPoint(x: 1, y: 1)
                : CGPoint(x: 0, y: 1)
            }
        }

        private func isLeftToRight() -> Bool {
            UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
        }
    }
}

// MARK: - Gradient Stop
public extension GradientImageView {
    struct Stop {
        let color: CGColor
        let point: NSNumber
    }
}
extension GradientImageView.Stop: Equatable {}

// MARK: - Lifecycle methods
public extension GradientImageView {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            setupUI()
            updateGradient()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = overlayView.frame
    }
}

public extension GradientImageView {
    func setCornerRadius(_ radius: CGFloat) {
        gradientLayer.cornerRadius = radius
        layer.cornerRadius = radius
    }
}

// MARK: - Private methods
private extension GradientImageView {
    func setupUI() {
        addSubview(overlayView)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.topAnchor.constraint(equalTo: overlayView.superview!.topAnchor).isActive = true
        overlayView.leftAnchor.constraint(equalTo: overlayView.superview!.leftAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: overlayView.superview!.bottomAnchor).isActive = true
        overlayView.rightAnchor.constraint(equalTo: overlayView.superview!.rightAnchor).isActive = true
        overlayView.layer.addSublayer(gradientLayer)
    }

    func updateGradient() {
        gradientLayer.colors = cgColors
        guard points.count >= 2 else {
            gradientLayer.startPoint = UnitPoint.top.point
            gradientLayer.endPoint = UnitPoint.bottom.point
            return
        }
        gradientLayer.startPoint = points.first!.point
        gradientLayer.endPoint = points.last!.point
        guard !stops.isEmpty else { return }
        gradientLayer.locations = stops.map { $0.point }
    }
}
