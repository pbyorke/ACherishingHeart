//
//  Item.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/17/21.
//

import SwiftUI

// MARK: - ItemType

enum ItemType: Int, Codable, CaseIterable {
    case unknown
    case music
    case video
    case document
    
    var title: String {
        switch self {
        case .unknown:  return ""
        case .music:    return "music"
        case .video:    return "video"
        case .document: return "document"
        }
    }
}

// MARK: - Item

struct Item: Identifiable, Codable, Equatable {
    var id:         String { didSet { id = id.trim() } }
    var name:       String { didSet { name = name.trim() } }
    var fullPath:   String { didSet { fullPath = fullPath.trim() } }
    var url:        String { didSet { url = url.trim() } }
    var type:       ItemType
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullPath
        case url
        case type
    }
    
}

// MARK: - Item extension

extension Item {
    static var new: Item {
        Item(
            id:         UUID().uuidString,
            name:       "",
            fullPath:   "",
            url:        "",
            type:       .unknown
        )
    }
}
