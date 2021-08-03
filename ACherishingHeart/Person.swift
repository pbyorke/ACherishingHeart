//
//  Person.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/26/21.
//

import Foundation

struct Person: Identifiable, Codable {
    var id: String
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var isMedia: Bool
    var isMaster: Bool
}

extension Person {
    static var new: Person {
        Person(
            id: UUID().uuidString,
            email: "",
            password: "",
            firstName: "",
            lastName: "",
            phoneNumber: "",
            isMedia: false,
            isMaster: false
        )
    }
}
