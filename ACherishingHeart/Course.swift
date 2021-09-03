//
//  Course.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import Foundation

struct Course: Identifiable, Codable {
    var id:          String
    var name:        String { didSet { name        = name.trim() } }
    var description: String { didSet { description = description.trim() } }
}

extension Course {
    static var new: Course {
        Course(
            id: UUID().uuidString,
            name: "",
            description: ""
        )
    }
}
