//
//  token.swift
//  swifty-companion
//
//  Created by arthur on 29/10/2020.
//

import Foundation

struct Token_gesture: Codable {

    var access_token, token_type, scope: String
    var expires_in, created_at: Int
}
