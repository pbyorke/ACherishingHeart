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

struct Item: Identifiable, Codable {
    var id:     String { didSet { id = id.trim() } }
    var name:   String { didSet { name = name.trim() } }
    var bucket: String { didSet { bucket = bucket.trim() } }
    var type:   ItemType
}

extension Item {
    static var new: Item {
        Item(
            id: UUID().uuidString,
            name: "",
            bucket: "",
            type: .unknown
        )
    }
}
