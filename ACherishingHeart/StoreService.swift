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
    func getOneByKey<T:Decodable>(collection: FirebaseReference, type: T.Type, key: String, value: String) async throws -> T?
    func getAll<T: Decodable>(collection: FirebaseReference, type: T.Type) async throws -> [T]
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
    
//    func getOneById<T: Decodable>(collection: FirebaseReference, type: T.Type, id: String) async throws -> T? {
//        do {
//            let snapshot = try await reference(to: collection).whereField("id", isEqualTo: id).getDocuments()
//            var objects = [T]()
//            try snapshot.documents.forEach { document in
//                let object = try document.decode(as: type.self)
//                objects.append(object)
//            }
//            if objects.count == 0 {
//                return nil
//            } else {
//                return objects[0]
//            }
//        } catch {
//            throw error
//        }
//    }
    
    func getAll<T: Decodable>(collection: FirebaseReference, type: T.Type) async throws -> [T] {
        do {
            let snapshot = try await reference(to: collection).getDocuments()
            var objects = [T]()
            try snapshot.documents.forEach { document in
                let object = try document.decode(as: type.self, includingId: false)
                objects.append(object)
            }
            return objects
        } catch {
            throw error
        }
    }

    func getOneById<T: Decodable>(collection: FirebaseReference, type: T.Type, id: String) async throws -> T? {
        do {
            let snapshot = try await reference(to: collection).whereField(FieldPath.documentID(), isEqualTo: id).getDocuments()
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
    
    func getAllByKey<T:Decodable>(collection: FirebaseReference, type: T.Type, key: String, value: String) async throws -> [T] {
        do {
            let snapshot = try await reference(to: collection).whereField(key, isEqualTo: value).getDocuments()
            var objects = [T]()
            try snapshot.documents.forEach { document in
                let object = try document.decode(as: type.self)
                objects.append(object)
            }
            return objects
        } catch {
            throw error
        }
    }
    
    func getOneByKey<T:Decodable>(collection: FirebaseReference, type: T.Type, key: String, value: String) async throws -> T? {
        do {
            let snapshot = try await reference(to: collection).whereField(key, isEqualTo: value).getDocuments()
            var objects = [T]()
            try snapshot.documents.forEach { document in
                let object = try document.decode(as: type.self)
                objects.append(object)
            }
            if objects.count > 0 {
                return objects[0]
            } else {
                return nil
            }
        } catch {
            throw error
        }
    }
    
//    func getAllByKey<T:Decodable>(collection: FirebaseReference, type: T.Type, key: String, value: String, done: @escaping ([T]) -> Void) {
//        reference(to: collection).whereField(key, isEqualTo: value).getDocuments { (snapshot, _) in
//            guard let snapshot = snapshot else { return }
//            do {
//                var objects = [T]()
//                for document in snapshot.documents {
//                    let object = try document.decode(as: type.self)
//                    objects.append(object)
//                }
//                done(objects)
//            } catch {
//                print(error)
//            }
//        }
//    }
    
    func getAllByKey<T:Decodable>(collection: FirebaseReference, type: T.Type, key: String, intValue: Int, done: @escaping ([T]) -> Void) {
        reference(to: collection).whereField(key, isEqualTo: intValue).getDocuments { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            do {
                var objects = [T]()
                for document in snapshot.documents {
                    let object = try document.decode(as: type.self)
                    objects.append(object)
                }
                done(objects)
            } catch {
                print(error)
            }
        }
    }
    
//    func getOneById<T: Decodable>(collection: FirebaseReference, type: T.Type, id: String) async throws -> T? {
//        do {
//            let snapshot = try await reference(to: collection).whereField("id", isEqualTo: id).getDocuments()
//            var objects = [T]()
//            try snapshot.documents.forEach { document in
//                let object = try document.decode(as: type.self)
//                objects.append(object)
//            }
//            if objects.count == 0 {
//                return nil
//            } else {
//                return objects[0]
//            }
//        } catch {
//            throw error
//        }
//    }
        
//    func getOneById<T: Decodable>(collection: FirebaseReference, type: T.Type, id: String, done: @escaping (T?) -> Void) {
//        reference(to: collection).whereField(FieldPath.documentID(), isEqualTo: id).getDocuments { (snapshot, error) in
//            guard let snapshot = snapshot else {
//                done(nil)
//                return
//            }
//            do {
//                var objects = [T]()
//                for document in snapshot.documents {
//                    let object = try document.decode(as: type.self)
//                    objects.append(object)
//                }
//                if objects.count == 0 {
//                    done(nil)
//                } else {
//                    done(objects[0])
//                }
//            } catch {
//                print(error)
//            }
//        }
//    }

//    func update<T: Encodable & Identifiable>(_ object: T, collection: FirebaseReference, done: @escaping (Result<T, FirebaseError>) -> Void) {
//        do {
//            let json = try object.toJson(excluding: ["id"])
//            guard let id = object.id else { throw FirebaseError.encodingError }
//            reference(to: collection).document(id).setData(json)
//            done(.success(object))
//        } catch {
//            done(.failure(.encodingError))
//        }
//    }
    
}
