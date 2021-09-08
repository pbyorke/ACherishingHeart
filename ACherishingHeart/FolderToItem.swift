//
//  FolderToItem.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/19/21.
//

import Foundation

struct FolderToItem: Identifiable, Codable {
    var id:         String
    var folderId:   String
    var folderName: String
    var itemId:     String
    var itemName:   String
    var sequence:   Int
}

extension FolderToItem {
    static var new: FolderToItem {
        FolderToItem(
        id:         UUID().uuidString,
        folderId:   UUID().uuidString,
        folderName: "",
        itemId:     UUID().uuidString,
        itemName:   "",
        sequence:   0
        )
    }
}
