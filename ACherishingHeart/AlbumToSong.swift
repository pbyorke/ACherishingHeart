//
//  AlbumToSong.swift
//  AlbumToSong
//
//  Created by Pete Yorke on 8/19/21.
//

import Foundation

struct AlbumToSong: Identifiable, Codable {
    var id: String
    var albumId: String
    var songId: String
}

extension AlbumToSong {
    static var new: AlbumToSong {
        AlbumToSong(
        id: UUID().uuidString,
        albumId: UUID().uuidString,
        songId: UUID().uuidString
        )
    }
}
