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
    func listAllMusic() async -> [Entry]
    func listAllSongs() async throws -> [Song]
    func listAllAlbums() async throws -> [Album]
}

final class StorageService: StorageServiceProtocol {
    
    static let shared = StorageService()
    var firestoreService: FirestoreServiceProtocol = FirestoreService.shared

    private func reference(to collection: StorageType) -> StorageReference {
        return Storage.storage().reference().child(collection.rawValue)
    }
    
    func listAllMusic() async -> [Entry] {
        var entries = [Entry]()
        do {
            let result = try await reference(to: .music).listAll()
            for item in result.items {
                let entry = Entry(
                    id: item.fullPath,
                    fullPath: item.fullPath,
                    bucket: item.bucket,
                    name: item.name,
                    description: item.description
                )
                entry.dump()
                entries.append(entry)
            }
            return entries
        } catch {
            return entries
        }
    }

    func listAllSongs() async throws -> [Song] {
        do {
            let songs = try await firestoreService.getAll(collection: .songs, type: Song.self)
            return songs
        } catch { throw error }
    }
    
    func listAllAlbums() async throws -> [Album] {
        do {
            let albums = try await firestoreService.getAll(collection: .albums, type: Album.self)
            return albums
        } catch { throw error }
    }
    
}
