//
//  Entry.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/16/21.
//

import Foundation

struct Entry: Identifiable {
    var id: String
    var fullPath: String
    var bucket: String
    var name: String
    var description: String
    
    func dump() {
        print("* * *  id          \"\(id)\"")
        print("* * *  fullPath    \"\(fullPath)\"")
        print("* * *  bucket      \"\(bucket)\"")
        print("* * *  name        \"\(name)\"")
        print("* * *  description \"\(description)\"")
        print("* * *  ")
    }
    
}
