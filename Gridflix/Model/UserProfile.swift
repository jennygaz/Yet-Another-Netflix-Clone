//
//  UserProfile.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 17/09/24.
//

import Foundation

public struct UserProfile: Equatable, Codable {
    public let id: UUID
    public let name: String
    public let email: String
    public let phone: String
    public let avatar: URL
}
