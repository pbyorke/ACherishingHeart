//
//  Trimmed.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/3/21.
//

import Foundation

@propertyWrapper struct Trimmed {
        
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue.trimmingCharacters(in: .whitespaces)
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.trimmingCharacters(in: .whitespaces)
    }
    
}
