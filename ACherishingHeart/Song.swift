//
//  Song.swift
//  Song
//
//  Created by Peter Yorke on 8/17/21.
//

import Foundation

struct Song: Identifiable, Codable {
    var id: String
    var name: String
}

extension Song {
    static var new: Song {
        Song(
            id: UUID().uuidString,
            name: ""
        )
    }
}
