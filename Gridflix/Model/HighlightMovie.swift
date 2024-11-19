struct HighlightMovie {
    let name: String
    let mainImage: String
    let logo: String
    var categories: [String]
    var isListed: Bool = false
    var backgroundColor: UIColor? = nil

    static let `default`: HighlightMovie = .init(
        name: "Naruto Shippuden",
        mainImage: "naruto_hero_view",
        logo: "naruto_logo",
        categories: [
            "Goofy",
            "Action",
            "Hero's Journey",
            "Anime",
            "Growth"
        ],
        isListed: false)
}