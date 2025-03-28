import Testing
import CoreGraphics
import UIKit
@testable import Gridflix

@MainActor
struct ComponentsTests {

    @Test func testBadgedUIButton() async throws {
        let config = UIButton.Configuration.plain()
        let button = BadgedUIButton(configuration: config)
        
        // Test initial state
        #expect(button.badgeValue == nil)
        #expect(button.badgeImage == nil)
        
        // Test setting badge value
        button.badgeValue = 5
        #expect(button.badgeValue == 5)
        
        // Test setting badge image
        let badgeImage = UIImage(systemName: "star.fill")
        button.badgeImage = badgeImage
        #expect(button.badgeImage == badgeImage)
        
        // Test removing badge image
        button.removeBadgeImage()
        #expect(button.badgeImage == nil)
    }

    @Test func testCAShapeLayerDrawCircle() async throws {
        let shapeLayer = CAShapeLayer()
        let location = CGPoint(x: 50, y: 50)
        let radius: CGFloat = 25
        let color = UIColor.red
        
        shapeLayer.drawCircleAt(location: location, radius: radius, color: color)
        
        #expect(shapeLayer.fillColor == color.cgColor)
        #expect(shapeLayer.strokeColor == color.cgColor)
        #expect(shapeLayer.path != nil)
    }

    @Test func testCategoryHeroLabel() async throws {
        let label = CategoryHeroLabel(text: "Test")
        
        #expect(label.text == "Test")
        #expect(label.textColor == .white)
        #expect(label.textAlignment == .center)
        
        let assetLabel = CategoryHeroLabel(assetName: "custom.dot")
        #expect(assetLabel.attributedText != nil)
    }

    @Test func testGradientImageView() async throws {
        let image = UIImage(systemName: "star.fill")
        let colors: [UIColor] = [.red, .blue]
        let gradientImageView = GradientImageView(image: image, colors: colors)
        
        #expect(gradientImageView.image == image)
        #expect(gradientImageView.colors == colors)
        
        let stops: [GradientImageView.Stop] = [
            .init(color: UIColor.red.cgColor, point: 0.0),
            .init(color: UIColor.blue.cgColor, point: 1.0)
        ]
        let gradientImageViewWithStops = GradientImageView(image: image, stops: stops)
        
        #expect(gradientImageViewWithStops.image == image)
        #expect(gradientImageViewWithStops.stops == stops)
    }
}
