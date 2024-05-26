//
//  SearchResult.swift
//  spotify
//
//  Created by MacBook Air on 5/20/24.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
