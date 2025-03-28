import Testing
import CoreGraphics
import UIKit
@testable import Gridflix

@MainActor
struct GridflixTests {

    @Test func testBadgedUIButton() async throws {
        let config = UIButton.Configuration.plain()
        let button = BadgedUIButton(configuration: config)
        button.setBadgeValue(count: 5)
        #expect(button.badgeValue == 5)
        button.setBadgeImage(image: UIImage(systemName: "star"))
        #expect(button.badgeImage != nil)
    }

    @Test func testCAShapeLayerDrawCircle() async throws {
        let shapeLayer = CAShapeLayer()
        shapeLayer.drawCircleAt(location: CGPoint(x: 50, y: 50), radius: 25, color: .red)
        #expect(shapeLayer.path != nil)
        #expect(shapeLayer.fillColor == UIColor.red.cgColor)
    }

    @Test func testCategoryHeroLabel() async throws {
        let label = CategoryHeroLabel(text: "Test")
        #expect(label.text == "Test")
        let attributedLabel = CategoryHeroLabel(assetName: "testImage")
        #expect(attributedLabel.attributedText != nil)
    }

    @Test func testGradientImageView() async throws {
        let imageView = GradientImageView(image: UIImage(systemName: "star"), colors: [.red, .blue])
        #expect(imageView.layer.sublayers?.contains(where: { $0 is CAGradientLayer }) == true)
    }

    @Test func testHomeHeaderView() async throws {
        let headerView = HomeHeaderView(frame: .zero)
        let model = HighlightMovie(name: "Test Movie", mainImage: "testImage", logo: "testLogo", categories: ["Action", "Drama"], isListed: true, backgroundColor: .black)
        headerView.configure(with: model)
        #expect(headerView.model.name == "Test Movie")
    }

    @Test func testCarouselItemView() async throws {
        let view = CarouselItemView(frame: .zero)
        let model = CarouselModel(imageName: "testImage", text: "Test Text")
        view.configure(with: model)
        #expect(view.model.text == "Test Text")
    }

    @Test func testHeroHeaderViewSwiftUI() async throws {
        // This test requires a SwiftUI environment to run
        // #expect(true)
    }

}
