//
//  Item.swift
//  ClothingStore
//
//  Created by Mindy Douglas on 11/8/22.
//

import Foundation

struct Item: Hashable {
    let id = UUID()
    let title: String
    let subtitle : String
    let rating: String
    let image: String
    let header: String
    
    init(title: String = "", subtitle: String = "", rating: String = "", image: String = "", header: String = "") {
        self.title = title
        self.subtitle = subtitle
        self.rating = rating
        self.image = image
        self.header = header
    }
}
