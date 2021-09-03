//
//  Payment.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import Foundation

struct Payment: Identifiable, Codable {
    var id:         String
    var personId:   String
    var amount:     Int
    var date:       String
}

extension Payment {
    static var new: Payment {
        Payment(
            id:         UUID().uuidString,
            personId:   "",
            amount:     0,
            date:       ""
        )
    }
}
