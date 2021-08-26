//
//  Encodable+Utils.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 7/31/21.
//

import UIKit

enum FirebaseError: Error {
    case encodingError
    case namedError(String)
    case notFound
}

extension Encodable {    
    func toJson(excluding keys: [String] = [String]()) throws -> [String: Any] {
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String:Any] else { throw FirebaseError.encodingError }
        for key in keys {
            json[key] = nil
        }
        return json
    }
    
}
