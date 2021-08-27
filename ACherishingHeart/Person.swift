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
    var inactive:       Bool // been made inactive on purpose
    var delinquent:     Bool // behind on monthly dues
    var media:          Bool // has permission to change items and folders
    var master:         Bool // can do everything
    var admin:          Bool // has permission to deal with persons
    var joyCoach:       Bool
    var JCTeacher:      Bool
    var JCStudent:      Bool
    var subscriber:     Bool // is paying for music
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
