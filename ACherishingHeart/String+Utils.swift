//
//  String+Utils.swift
//  String+Utils
//
//  Created by Peter Yorke on 7/31/21.
//

import Foundation

extension String {
    
    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
