//
//  FolderToCourse.swift
//  FolderToCourse
//
//  Created by Peter Yorke on 8/28/21.
//

import Foundation

struct FolderToCourse: Identifiable, Codable {
    var id:         String
    var folderId:   String
    var courseId:   String
}

extension FolderToCourse {
    static var new: FolderToCourse {
        FolderToCourse(
            id:         UUID().uuidString,
            folderId:   UUID().uuidString,
            courseId:   UUID().uuidString
        )
    }
}
