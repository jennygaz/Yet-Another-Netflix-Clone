//
//  ProfileItem.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 17/09/24.
//
import UIKit

struct ProfileItem: Hashable {
    let name: String
    let color: UIColor
    let type: ProfileType

    init(name: String, color: UIColor, type: ProfileType = .custom) {
        self.name = name
        self.color = color
        self.type = type
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

enum ProfileSection: String {
    case main = "Who's watching?"
}
