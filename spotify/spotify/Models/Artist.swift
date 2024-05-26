//
//  Artist.swift
//  spotify
//
//  Created by MacBook Air on 4/10/24.
//

import Foundation


struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}
