//
//  CloudFile.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/16/21.
//

import Foundation

struct CloudFile: Identifiable {
    var id: String
    var fullPath: String
    var bucket: String
    var name: String
    var description: String
    
    func dump() {
        print("id          \"\(id)\"")
        print("fullPath    \"\(fullPath)\"")
        print("bucket      \"\(bucket)\"")
        print("name        \"\(name)\"")
        print("description \"\(description)\"")
        print("")
    }
    
}

extension CloudFile {
    static var new: CloudFile {
        CloudFile(
            id: UUID().uuidString,
            fullPath: "",
            bucket: "",
            name: "",
            description: ""
        )
    }
}
