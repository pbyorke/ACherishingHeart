//
//  Album.swift
//  Album
//
//  Created by Peter Yorke on 8/17/21.
//

import Foundation

struct Album: Identifiable, Codable {
    var id: String
    var name: String
}

extension Album {
    static var new: Album {
        Album(
            id: UUID().uuidString,
            name: ""
        )
    }
}
