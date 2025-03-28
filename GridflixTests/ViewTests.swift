import Testing
@testable import Gridflix

struct ViewTests {

    @Test func testHomeHeaderView() async throws {
        let frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        let homeHeaderView = HomeHeaderView(frame: frame)
        
        // Test initial state
        #expect(homeHeaderView.model.name == "Naruto Shippuden")
        #expect(homeHeaderView.model.mainImage == "naruto_hero_view")
        #expect(homeHeaderView.model.logo == "naruto_logo")
        #expect(homeHeaderView.model.categories == ["Ninja", "Slow Pace", "Fighting", "Edgy", "Dark"])
        #expect(homeHeaderView.model.isListed == true)
        #expect(homeHeaderView.model.backgroundColor == .black.withAlphaComponent(0.8))
        
        // Test updating model
        let newModel = HighlightMovie(
            name: "One Piece",
            mainImage: "one_piece_hero_view",
            logo: "one_piece_logo",
            categories: ["Pirate", "Adventure", "Action"],
            isListed: false,
            backgroundColor: .blue.withAlphaComponent(0.8))
        homeHeaderView.model = newModel
        
        #expect(homeHeaderView.model.name == "One Piece")
        #expect(homeHeaderView.model.mainImage == "one_piece_hero_view")
        #expect(homeHeaderView.model.logo == "one_piece_logo")
        #expect(homeHeaderView.model.categories == ["Pirate", "Adventure", "Action"])
        #expect(homeHeaderView.model.isListed == false)
        #expect(homeHeaderView.model.backgroundColor == .blue.withAlphaComponent(0.8))
    }

    @Test func testCarouselItemView() async throws {
        let frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        let carouselItemView = CarouselItemView(frame: frame)
        
        // Test initial state
        #expect(carouselItemView.model.imageName == "naruto_hero_view")
        #expect(carouselItemView.model.text == "Naruto Shippuden")
        
        // Test updating model
        let newModel = CarouselModel(imageName: "one_piece_hero_view", text: "One Piece")
        carouselItemView.configure(with: newModel)
        
        #expect(carouselItemView.model.imageName == "one_piece_hero_view")
        #expect(carouselItemView.model.text == "One Piece")
    }

    @Test func testHeroHeaderViewSwiftUI() async throws {
        @State var movieData = MovieData(
            movieName: "Naruto Shippuden",
            imageURL: "naruto_hero_view",
            logoURL: "naruto_logo",
            categories: [.action, .anime, .comedies, .downloadable, .fantasy, .myList],
            descriptors: [.goofy, .action, .heroJourney, .anime, .growth])
        let heroHeaderView = HeroHeaderViewSwiftUI(movieData: $movieData)
        
        // Test initial state
        #expect(movieData.movieName == "Naruto Shippuden")
        #expect(movieData.imageURL == "naruto_hero_view")
        #expect(movieData.logoURL == "naruto_logo")
        #expect(movieData.categories == [.action, .anime, .comedies, .downloadable, .fantasy, .myList])
        #expect(movieData.descriptors == [.goofy, .action, .heroJourney, .anime, .growth])
        
        // Test updating movieData
        movieData.movieName = "One Piece"
        movieData.imageURL = "one_piece_hero_view"
        movieData.logoURL = "one_piece_logo"
        movieData.categories = [.action, .adventure, .pirate]
        movieData.descriptors = [.adventure, .action, .pirate]
        
        #expect(movieData.movieName == "One Piece")
        #expect(movieData.imageURL == "one_piece_hero_view")
        #expect(movieData.logoURL == "one_piece_logo")
        #expect(movieData.categories == [.action, .adventure, .pirate])
        #expect(movieData.descriptors == [.adventure, .action, .pirate])
    }
}
