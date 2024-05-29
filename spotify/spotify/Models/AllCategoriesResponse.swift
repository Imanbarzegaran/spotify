//
//  AllCategoriesResponse.swift
//  spotify
//
//  Created by MacBook Air on 5/13/24.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
  
}
struct Categories: Codable {
    let items: [Category]
}
struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
    
    
}




    
   
                   