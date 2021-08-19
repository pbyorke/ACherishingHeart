//
//  DocumentSnapshot+Utils.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/1/21.
//

import FirebaseFirestore

extension DocumentSnapshot {
    
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T {
        guard var documentJson = data() else { throw  FirebaseError.encodingError }
        if includingId {
            documentJson["id"] = documentID
        }
        let documentData = try JSONSerialization.data(withJSONObject: documentJson, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        return decodedObject
    }
    
}
