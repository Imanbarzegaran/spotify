//
//  SettingsModels.swift
//  spotify
//
//  Created by MacBook Air on 4/23/24.
//

import Foundation


struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
