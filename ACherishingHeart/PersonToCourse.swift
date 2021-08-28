//
//  PersonToCourse.swift
//  PersonToCourse
//
//  Created by Peter Yorke on 8/28/21.
//

import Foundation

struct PersonToCourse: Identifiable, Codable {
    var id:         String
    var personId:   String
    var courseId:   String
}

extension PersonToCourse {
    static var new: PersonToCourse {
        PersonToCourse(
            id:         UUID().uuidString,
            personId:   UUID().uuidString,
            courseId:   UUID().uuidString
        )
    }
}
