//
//  Playlist.swift
//  spotify
//
//  Created by MacBook Air on 4/10/24.
//

import Foundation


struct Playlist: Codable {
    
    let description: String
    let external_urls: [String: String]
    let id: String
    let images:[APIImage]
    let name: String
    let owner: User
}
