//
//  AuthToken.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 17/09/24.
//

import Foundation

public enum AuthToken {
    case raw(String)
    case jwt(String)
    case b64(String)

    var value: String {
        switch self {
        case .raw(let string): return string
        case .jwt(let string): return string
        case .b64(let string): return string
        }
    }
}
