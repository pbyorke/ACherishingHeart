//
//  Person.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/26/21.
//

import Foundation

struct Person: Identifiable, Codable {
//    var id:           String
//    var userUID:      String
//    var email:        String { didSet { email       = email.trim() } }
//    var password:     String { didSet { password    = password.trim() } }
//    var firstName:    String { didSet { firstName   = firstName.trim() } }
//    var lastName:     String { didSet { lastName    = lastName.trim() } }
//    var phoneNumber:  String { didSet { phoneNumber = phoneNumber.trim() } }
//    var anonymous:    Bool // has not created an individual account
//    var inactive:     Bool // been made inactive on purpose
//    var delinquent:   Bool // behind on monthly dues
//    var media:        Bool // has permission to change items and folders and courses
//    var master:       Bool // can do everything
//    var admin:        Bool // has permission to deal with persons
//    var finance:      Bool // can set promisedRate, etc
//    var subscriber:   Bool // is paying for music
//    var joyCoach:     Bool // is a registered Joy Coach
//    var JCTeacher:    Bool // is a registered Joy Coach Teacher
//    var JCStudent:    Bool // is a student Joy Coach
//    var promisedRate: Int  // monthly subscription amount promised in cents
    
    var id            = ""
    var userUID       = ""
    var email         = "" { didSet { email       = email.trim() } }
    var password      = "" { didSet { password    = password.trim() } }
    var firstName     = "" { didSet { firstName   = firstName.trim() } }
    var lastName      = "" { didSet { lastName    = lastName.trim() } }
    var phoneNumber   = "" { didSet { phoneNumber = phoneNumber.trim() } }
    var anonymous     = false // has not created an individual account
    var inactive      = false // been made inactive on purpose
    var delinquent    = false // behind on monthly dues
    var media         = false // has permission to change items and folders and courses
    var master        = false // can do everything
    var admin         = false // has permission to deal with persons
    var finance       = false // can set promisedRate, etc
    var subscriber    = false // is paying for music
    var joyCoach      = false // is a registered Joy Coach
    var JCTeacher     = false // is a registered Joy Coach Teacher
    var JCStudent     = false // is a student Joy Coach
    var promisedRate  = 0  // monthly subscription amount promised in cents
}

//extension Person {
//    
//    static var new: Person {
//        Person(
//            id:             UUID().uuidString,
//            userUID:        "",
//            email:          "",
//            password:       "",
//            firstName:      "",
//            lastName:       "",
//            phoneNumber:    "",
//            anonymous:      false,
//            inactive:       false,
//            delinquent:     false,
//            media:          false,
//            master:         false,
//            admin:          false,
//            finance:        false,
//            subscriber:     false,
//            joyCoach:       false,
//            JCTeacher:      false,
//            JCStudent:      false,
//            promisedRate:   0
//        )
//    }
//    
//    static func basicPerson(uid: String, email: String, password: String) -> Person {
//        Person(
//            id:             "",
//            userUID:        uid,
//            email:          email,
//            password:       password,
//            firstName:      "",
//            lastName:       "",
//            phoneNumber:    "",
//            anonymous:      false,
//            inactive:       false,
//            delinquent:     false,
//            media:          false,
//            master:         false,
//            admin:          false,
//            finance:        false,
//            subscriber:     false,
//            joyCoach:       false,
//            JCTeacher:      false,
//            JCStudent:      false,
//            promisedRate:   0
//        )
//    }
//    
//    static func namedPerson(uid: String, email: String, password: String, firstName: String, lastName: String, phoneNumber: String, promisedRate: Int) -> Person {
//        Person(
//            id:             "",
//            userUID:        uid,
//            email:          email,
//            password:       password,
//            firstName:      firstName,
//            lastName:       lastName,
//            phoneNumber:    phoneNumber,
//            anonymous:      false,
//            inactive:       false,
//            delinquent:     false,
//            media:          false,
//            master:         false,
//            admin:          false,
//            finance:        false,
//            subscriber:     false,
//            joyCoach:       false,
//            JCTeacher:      false,
//            JCStudent:      false,
//            promisedRate:   promisedRate
//        )
//    }
//    
//}
