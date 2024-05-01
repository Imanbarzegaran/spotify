//
//  FeaturedPlaylistResponse.swift
//  spotify
//
//  Created by MacBook Air on 4/29/24.
//

import Foundation

struct FeaturedPlaylistResponse: Codable {
    
    let playlists: PlaylistResponse
    
}

struct PlaylistResponse: Codable {
    
    let items: [Playlist]
    
}




struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String

}



