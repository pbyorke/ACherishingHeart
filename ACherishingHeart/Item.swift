//
//  Song.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/17/21.
//

import Foundation

enum ItemType: Int, Codable, CaseIterable {
    case unknown
    case music
    
    var title: String {
        switch self {
        case .unknown:  return ""
        case .music:    return "music"
        }
    }
}

struct Item: Identifiable, Codable {
    var id: String
    var name: String
    var type: ItemType
}

extension Item {
    static var new: Item {
        Item(
            id: UUID().uuidString,
            name: "",
            type: .unknown
        )
    }
}
