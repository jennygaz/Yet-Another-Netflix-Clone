//
//  Title.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 27/11/24.
//

import Foundation

struct Title: Codable {
    let id: Int
    let mediaType: String
    let name: String
    let title: String
    let posterURL: String
    let description: String
    let voteCount: Int
    let voteAverage: Double
    let releaseDate: Date

    enum CodingKeys: String, CodingKey {
    case id          = "id"
    case mediaType   = "media_type"
    case name        = "original_name"
    case title       = "original_title"
    case posterURL   = "poster_path"
    case description = "overview"
    case voteCount   = "vote_count"
    case voteAverage = "vote_average"
    case releaseDate = "release_date"
    }
}

extension Title: Equatable {
    static func == (_ lhs: Title, _ rhs: Title) -> Bool {
        lhs.id == rhs.id
    }
}

extension Title: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
