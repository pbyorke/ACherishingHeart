//
//  StoreService.swift
//  StoreService
//
//  Created by Peter Yorke on 7/31/21.
//

import Foundation
import FirebaseFirestore

enum FirebaseReference: String {
    case users
}

protocol StoreServiceProtocol {
    func create<T: Codable>(_ object: T, collection: FirebaseReference) async throws
    func getOneById<T: Decodable>(collection: FirebaseReference, type: T.Type, id: String) async throws -> T?
}

final class StoreService: StoreServiceProtocol {
    
    static let shared = StoreService()
    
    private func reference(to collection: FirebaseReference) -> CollectionReference {
        return Firestore.firestore().collection(collection.rawValue)
    }
    
    func create<T: Codable>(_ object: T, collection: FirebaseReference) async throws {
        do {
            let json = try object.toJson()
            reference(to: collection).addDocument(data: json)
        } catch {
            throw error
        }
    }
    
    func getOneById<T: Decodable>(collection: FirebaseReference, type: T.Type, id: String) async throws -> T? {
        do {
//            let snapshot = try await reference(to: collection).whereField(FieldPath.documentID(), isEqualTo: id).getDocuments()
            let snapshot = try await reference(to: collection).whereField("id", isEqualTo: id).getDocuments()
            var objects = [T]()
            try snapshot.documents.forEach { document in
                let object = try document.decode(as: type.self)
                objects.append(object)
            }
            if objects.count == 0 {
                return nil
            } else {
                return objects[0]
            }
        } catch {
            throw error
        }
    }

}
