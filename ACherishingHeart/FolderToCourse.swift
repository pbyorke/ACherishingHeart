//
//  FolderToCourse.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import Foundation

struct FolderToCourse: Identifiable, Codable {
    var id:         String
    var folderId:   String
    var folderName: String
    var courseId:   String
    var courseName: String
    var sequence:   Int
}

extension FolderToCourse {
    static var new: FolderToCourse {
        FolderToCourse(
            id:         UUID().uuidString,
            folderId:   UUID().uuidString,
            folderName: "",
            courseId:   UUID().uuidString,
            courseName: "",
            sequence:   0
        )
    }
}
