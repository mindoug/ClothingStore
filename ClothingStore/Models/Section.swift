//
//  Section.swift
//  ClothingStore
//
//  Created by Mindy Douglas on 11/8/22.
//

import Foundation

struct Section: Hashable {
    let id = UUID()
    
    let type: SectionType
    let title: String
    let items: [Item]
    
    init(type: SectionType, title: String = "", subtitle: String = "", items: [Item] = []) {
        self.type = type
        self.title = title
        self.items = items
    }
    
    enum ItemSectionType: String {
        case large
        case ad
        case rating
        case header
    }
    
    struct SectionType: RawRepresentable, Hashable {
        typealias RawValue = String
        var rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        static let large = SectionType(rawValue: Section.ItemSectionType.large.rawValue)
        static let ad = SectionType(rawValue: Section.ItemSectionType.ad.rawValue)
        static let rating = SectionType(rawValue: Section.ItemSectionType.rating.rawValue)
        static let header = SectionType(rawValue: Section.ItemSectionType.header.rawValue)

    }
}
