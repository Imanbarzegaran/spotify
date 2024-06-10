//
//  LibraryAlbumsResponse.swift
//  spotify
//
//  Created by MacBook Air on 6/9/24.
//

import Foundation
struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
    
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
