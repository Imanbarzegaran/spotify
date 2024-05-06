//
//  PlaylistDetailsResponse.swift
//  spotify
//
//  Created by MacBook Air on 5/6/24.
//

import Foundation


struct PlaylistDetailsResponse: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTracksResponse
}


struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}


struct PlaylistItem: Codable {
    let track: AudioTrack
}



