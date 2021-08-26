//
//  StorageService.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/16/21.
//

import Foundation
import FirebaseStorage

enum StorageType: String {
    case music
}

protocol StorageServiceProtocol {
//    func listAllMusic() async -> [StorageEntry]
    func listAllItems() async throws -> [Item]
    func listAllFolders() async throws -> [Folder]
}

final class StorageService: ObservableObject, StorageServiceProtocol {
    
    static let shared = StorageService()
    var firestoreService: FirestoreServiceProtocol = FirestoreService.shared

    private func reference(to collection: StorageType) -> StorageReference {
        return Storage.storage().reference().child(collection.rawValue)
    }
    
//    func listAllMusic() async -> [StorageEntry] {
//        var entries = [StorageEntry]()
//        do {
//            let result = try await reference(to: .music).listAll()
//            for item in result.items {
//                let entry = StorageEntry(
//                    id: item.fullPath,
//                    fullPath: item.fullPath,
//                    bucket: item.bucket,
//                    name: item.name,
//                    description: item.description
//                )
//                entry.dump()
//                entries.append(entry)
//            }
//            return entries
//        } catch {
//            return entries
//        }
//    }

    func listAllItems() async throws -> [Item] {
        do {
            let songs = try await firestoreService.getAll(collection: .items, type: Item.self)
            return songs
        } catch { throw error }
    }

    func listAllFolders() async throws -> [Folder] {
        do {
            let folders = try await firestoreService.getAll(collection: .folders, type: Folder.self)
            return folders
        } catch { throw error }
    }
    
    func updateItem(_ item: Item) throws {
        do {
            try firestoreService.update(item, collection: .items)
        } catch {
            throw error
        }
    }
    
}
