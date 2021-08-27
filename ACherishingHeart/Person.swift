//
//  Person.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/26/21.
//

import Foundation

struct Person: Identifiable, Codable {
    var id:             String
    var userUID:        String
    var email:          String { didSet { email       = email.trim() } }
    var password:       String { didSet { password    = password.trim() } }
    var firstName:      String { didSet { firstName   = firstName.trim() } }
    var lastName:       String { didSet { lastName    = lastName.trim() } }
    var phoneNumber:    String { didSet { phoneNumber = phoneNumber.trim() } }
    var inactive:       Bool
    var delinquent:     Bool
    var media:          Bool
    var master:         Bool
    var admin:          Bool
    var joyCoach:       Bool
    var JCTeacher:      Bool
    var JCStudent:      Bool
    var subscriber:     Bool
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
            inactive: false,
            delinquent: false,
            media: false,
            master: false,
            admin: false,
            joyCoach: false,
            JCTeacher: false,
            JCStudent: false,
            subscriber: false
        )
    }
}
