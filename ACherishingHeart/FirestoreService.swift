//
//  StoreService.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 7/31/21.
//
// https://peterfriese.dev/replicating-reminder-swiftui-firebase-part2/
//
//   @DocumentID var id: String?
//   @ServerTimestamp var createdTime: Timestamp?
//
//  class FirestoreTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
// var db = Firestore.firestore() // (1)
//
// override init() {
//   super.init()
//   loadData()
// }
//
// private func loadData() {
//   db.collection("tasks").order(by: "createdTime").addSnapshotListener { (querySnapshot, error) in // (2)
//     if let querySnapshot = querySnapshot {
//       self.tasks = querySnapshot.documents.compactMap { document -> Task? in // (3)
//         try? document.data(as: Task.self) // (4)
//       }
//     }
//   }
// }
// }
//
// func addTask(_ task: Task) {
//     do {
//       let _ = try db.collection("tasks").addDocument(from: task)
//     }
//     catch {
//       print("There was an error while trying to save a task \(error.localizedDescription).")
//     }
//   }
// }
//
//   func updateTask(_ task: Task) {
//     if let taskID = task.id {
//       do {
//         try db.collection("tasks").document(taskID).setData(from: task) // (1)
//       }
//       catch {
//         print("There was an error while trying to update a task \(error.localizedDescription).")
//       }
//     }
//   }
// }
//
//  func removeTask(_ task: Task) {
// if let taskID = task.id {
//   db.collection("tasks").document(taskID).delete { (error) in // (1)
//     if let error = error {
//       print("Error removing document: \(error.localizedDescription)")
//     }
//   }
// }
// }
// }
//


import Foundation
import FirebaseFirestore

enum FirestoreType: String {
    case courses
    case folders
    case foldersToCourses
    case foldersToItems
    case items
    case payments
    case persons
    case personsToCourses
}

protocol FirestoreServiceProtocol {
    func create<T: Codable>(_ object: T, collection: FirestoreType) async throws
    func getOneById<T: Decodable>(collection: FirestoreType, type: T.Type, id: String) async throws -> T?
    func getOneByKey<T:Decodable>(collection: FirestoreType, type: T.Type, key: String, value: String) async throws -> T?
    func getAll<T: Decodable>(collection: FirestoreType, type: T.Type) async throws -> [T]
    func update<T: Encodable & Identifiable>(_ object: T, collection: FirestoreType) throws
    func getAllByKey<T:Decodable>(collection: FirestoreType, type: T.Type, key: String, value: String) async throws -> [T]
    func getAllByKey<T:Decodable>(collection: FirestoreType, type: T.Type, key: String, value: Int) async throws -> [T]
}

final class FirestoreService: FirestoreServiceProtocol {
    
    static let shared = FirestoreService()
    
    private func reference(to collection: FirestoreType) -> CollectionReference {
        return Firestore.firestore().collection(collection.rawValue)
    }

    func create<T: Codable>(_ object: T, collection: FirestoreType) async throws {
        do {
            let json = try object.toJson(excluding: ["id"])
            reference(to: collection).addDocument(data: json)
        } catch {
            throw error
        }
    }

    func getAll<T: Decodable>(collection: FirestoreType, type: T.Type) async throws -> [T] {
        do {
            let snapshot = try await reference(to: collection).getDocuments()
            var objects = [T]()
            try snapshot.documents.forEach { document in
                let object = try document.decode(as: type.self, includingId: true)
                objects.append(object)
            }
            return objects
        } catch {
            throw error
        }
    }
    
    func getOneById<T: Decodable>(collection: FirestoreType, type: T.Type, id: String) async throws -> T? {
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
    
    func getAllByKey<T:Decodable>(collection: FirestoreType, type: T.Type, key: String, value: String) async throws -> [T] {
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
    
    func getAllByKey<T:Decodable>(collection: FirestoreType, type: T.Type, key: String, value: Int) async throws -> [T] {
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
    
    func getOneByKey<T:Decodable>(collection: FirestoreType, type: T.Type, key: String, value: String) async throws -> T? {
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
    
    func update<T: Encodable & Identifiable>(_ object: T, collection: FirestoreType) throws {
        do {
            let json = try object.toJson(excluding: ["id"])
            let id = "\(object.id)"
            reference(to: collection).document(id).setData(json)
        } catch {
            throw FirebaseError.namedError(error.localizedDescription)
        }
    }
    
}
