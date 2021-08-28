//
//  FolderToItem.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/19/21.
//

import Foundation

struct FolderToItem: Identifiable, Codable {
    var id:       String
    var folderId: String
    var itemId:   String
    var sequence: Int
}

extension FolderToItem {
    static var new: FolderToItem {
        FolderToItem(
        id:         UUID().uuidString,
        folderId:   UUID().uuidString,
        itemId:     UUID().uuidString,
        sequence:   0
        )
    }
}
