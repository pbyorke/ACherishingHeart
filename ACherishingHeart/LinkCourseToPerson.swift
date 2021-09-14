//
//  LinkCourseToPerson.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 9/11/21.
//

import Foundation

struct LinkCourseToPerson: Identifiable, Codable {
    var id:         String
    var personId:   String
    var personName: String
    var courseId:   String
    var courseName: String
    var sequence:   Int
}

extension LinkCourseToPerson {
    static var new: LinkCourseToPerson {
        LinkCourseToPerson(
            id:         UUID().uuidString,
            personId:   UUID().uuidString,
            personName: "",
            courseId:   UUID().uuidString,
            courseName: "",
            sequence:   0
        )
    }
}
