//
//  DataStore.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 4/14/22.
//

import SwiftUI

class DataStore {

    @AppStorage("defaultPerson") private var defaultPerson: Data = Data()
    
    private var encoder = JSONEncoder()
    private var decoder = JSONDecoder()

    var person: Person?
        
    func getDefaultPerson() -> Person? {
        person = try? decoder.decode(Person.self, from: defaultPerson)
        return person
    }
    
    func setDefaultPerson(_ person: Person?) async {
        if let personData = try? encoder.encode(person) {
            defaultPerson = personData
        }
    }
    
}
