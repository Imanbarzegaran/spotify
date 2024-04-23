//
//  AuthResponse.swift
//  spotify
//
//  Created by MacBook Air on 4/17/24.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}

