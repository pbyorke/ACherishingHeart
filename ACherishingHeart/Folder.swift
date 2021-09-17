//
//  Folder.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/17/21.
//

import Foundation

struct Folder:      Identifiable, Codable {
    var id:         String
    var name:       String { didSet { name = name.trim() } }
    var playlist:   Bool
    var common:     Bool
}

extension Folder {
    static var new: Folder {
        Folder(
            id:         UUID().uuidString,
            name:       "",
            playlist:   false,
            common:     false
        )
    }
}
