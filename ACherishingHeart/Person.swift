//
//  Person.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/26/21.
//

import Foundation

struct Person: Identifiable, Codable {
    var id: String
    var userUID: String
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var media: Bool
    var master: Bool
    var admin: Bool
    var joyCoach: Bool
    var JCTeacher: Bool
    var JCStudent: Bool
}

extension Person {
    static var new: Person {
        Person(
            id: UUID().uuidString,
            userUID: "",
            email: "",
            password: "",
            firstName: "",
            lastName: "",
            phoneNumber: "",
            media: false,
            master: false,
            admin: false,
            joyCoach: false,
            JCTeacher: false,
            JCStudent: false
        )
    }
}
