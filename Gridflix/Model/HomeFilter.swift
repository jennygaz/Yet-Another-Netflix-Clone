//
//  HomeFilter.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 18/10/24.
//

enum HomeFilter: Identifiable, CaseIterable, CustomStringConvertible {
    static let allCases: [HomeFilter] = [.tvShows, .movies]

    case tvShows
    case movies
    case categories(Category)

    var id: String { description }

    var description: String {
        switch self {
        case .tvShows: "TV Series"
        case .movies: "Movies"
        case .categories(let category): category.rawValue
        }
    }

    enum Category: String, CaseIterable, CustomStringConvertible {
        case home                      = "Home"
        case myList                    = "My List"
        case downloadable              = "Available for Download"
        case action                    = "Action"
        case anime                     = "Anime"
        case comedies                  = "Comedies"
        case criticallyAcclaimed       = "Critically Acclaimed"
        case documentaries             = "Documentaries"
        case dramas                    = "Dramas"
        case fantasy                   = "Fantasy"
        case halloween                 = "Halloween"
//        case christmas           = "Christmas"
        case hollywood                 = "Hollywood"
        case international             = "International"
        case kidsAndFamily             = "Kids & Family"
        case latinAmerican             = "Latin American"
        case mexican                   = "Mexican"
        case musicAndMusicals          = "Music & Musicals"
        case police                    = "Police"
        case reality                   = "Reality"
        case romance                   = "Romance"
        case scifi                     = "Sci-Fi"
        case sports                    = "Sports"
        case standUp                   = "Stand-Up"
        case thrillers                 = "Thrillers"
        case audioDescriptionInEnglish = "Audio Description in English"

        var description: String { rawValue }
    }
}

extension HomeFilter: Equatable {
    static func == (_ lhs: HomeFilter, _ rhs: HomeFilter) -> Bool {
        switch (lhs, rhs) {
        case (.tvShows, .tvShows), (.movies, .movies):
            return true
        case (.tvShows, .movies), (.movies, .tvShows),
            (.tvShows, .categories(_)), (.movies, .categories(_)):
            return false
        case (.categories(let leftCategory), .categories(let rightCategory)):
            return leftCategory == rightCategory
        default: return false
        }
    }
}
