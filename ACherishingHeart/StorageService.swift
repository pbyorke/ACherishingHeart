//
//  StorageService.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/16/21.
//
// Download files with Cloud Storage on iOS
// https://firebase.google.com/docs/storage/ios/download-files
//
// Upload files with Cloud Storage on iOS
// https://firebase.google.com/docs/storage/ios/upload-files
//
// Firebase Storage
// https://designcode.io/swiftui-advanced-handbook-firebase-storage
//

import Foundation
import FirebaseStorage
import CoreMIDI

enum StorageType: String {
    case music
}

protocol StorageServiceProtocol {
    func allCloudFiles() async -> [CloudFile]
    func listAllItems() async throws -> [Item]
    func listAllCourses() async throws -> [Course]
    func listAllFolders() async throws -> [Folder]
    func createFolderToItem(_ folderToItem: FolderToItem) async throws
    func listAllFoldersToItems(folderId: String) async throws -> [FolderToItem]
    func removeFolderToItem(_ folderToItem: FolderToItem) throws
    func removeFolderToCourse(_ folderToCourse: LinkCourseToFolder) throws
    func createItem(_ item: Item) async throws
    func updateItem(_ item: Item) throws
    func createCourse(_ course: Course) async throws
    func updateCourse(_ course: Course) throws
    func createFolder(_ folder: Folder) async throws
    func updateFolder(_ folder: Folder) throws
    func rewriteItemsForFolder(_ folder: Folder, _ items: [Item]) async throws
    func rewriteCoursesForFolder(_ folder: Folder, _ courses: [Course]) async throws
    func itemsInFolder(folderId: String) async throws -> [Item]
    
    // course to folder link
    func createCourseToFolderLink(_ link: LinkCourseToFolder) async throws
    func coursesInFolder(folderId: String) async throws -> [Course]
    func listAllCoursesInFolder(folderId: String) async throws -> [LinkCourseToFolder]
}

final class StorageService: StorageServiceProtocol {

    static let shared = StorageService()
    
    var firestoreService: FirestoreServiceProtocol = FirestoreService.shared

    private func reference(to collection: StorageType) -> StorageReference {
        return Storage.storage().reference().child(collection.rawValue)
    }
    
    func allCloudFiles() async -> [CloudFile] {
        var entries = [CloudFile]()
        do {
            let result = try await reference(to: .music).listAll()
            for item in result.items {
                let entry = CloudFile(
                    id: item.fullPath,
                    fullPath: item.fullPath,
                    bucket: item.bucket,
                    name: item.name,
                    description: item.description
                )
                entries.append(entry)
            }
            return entries
        } catch {
            return entries
        }
    }

    func listAllItems() async throws -> [Item] {
        do {
            let items = try await firestoreService.getAll(collection: .items, type: Item.self)
            return items
        } catch { throw error }
    }

    func listAllCourses() async throws -> [Course] {
        do {
            let courses = try await firestoreService.getAll(collection: .courses, type: Course.self)
            return courses
        } catch { throw error }
    }

    func createFolderToItem(_ folderToItem: FolderToItem) async throws {
        do {
            try await firestoreService.create(folderToItem, collection: .foldersToItems)
        } catch { throw error }
    }
    
    func listAllFolders() async throws -> [Folder] {
        do {
            let folders = try await firestoreService.getAll(collection: .folders, type: Folder.self)
            return folders
        } catch { throw error }
    }
    
    func listAllFoldersToItems(folderId: String) async throws -> [FolderToItem] {
        do {
            let foldersToItems = try await firestoreService.getAllByKey(collection: .foldersToItems, type: FolderToItem.self, key: "folderId", value: folderId, order: "sequence")
            return foldersToItems
        } catch { throw error
        }
    }
    
    func createItem(_ item: Item) async throws {
        do {
            try await firestoreService.create(item, collection: .items)
        } catch {
            throw error
        }
    }
    
    func updateItem(_ item: Item) throws {
        do {
            try firestoreService.update(item, collection: .items)
        } catch {
            throw error
        }
    }
    
    func createCourse(_ course: Course) async throws {
        do {
            try await firestoreService.create(course, collection: .courses)
        } catch {
            throw error
        }
    }
    
    func updateCourse(_ course: Course) throws {
        do {
            try firestoreService.update(course, collection: .courses)
        } catch {
            throw error
        }
    }
    
    func createFolder(_ folder: Folder) async throws {
        do {
            try await firestoreService.create(folder, collection: .folders)
        } catch {
            throw error
        }
    }
    
    func updateFolder(_ folder: Folder) throws {
        do {
            try firestoreService.update(folder, collection: .folders)
        } catch {
            throw error
        }
    }
    
    func rewriteItemsForFolder(_ folder: Folder, _ items: [Item]) async throws {
        print("* * *  folder: \(folder) items \(items)")
    }
    
    func rewriteCoursesForFolder(_ folder: Folder, _ courses: [Course]) async throws {
        print("* * *  folder: \(folder) courses \(courses)")
    }

    func itemsInFolder(folderId: String) async throws -> [Item] {
        do {
            let links = try await firestoreService.getAllByKey(
                collection: .foldersToItems,
                type: FolderToItem.self,
                key: "folderId",
                value: folderId
            )
            var items = [Item]()
            for link in links {
                if let item = try await firestoreService.getOneById(collection: .items, type: Item.self, id: link.itemId) {
                    items.append(item)
                }
            }
            return items
        } catch { throw error }
    }

    func removeFolderToItem(_ folderToItem: FolderToItem) throws {
        do {
            try firestoreService.remove(folderToItem, collection: .foldersToItems)
        } catch { throw error }
    }
    
    func removeFolderToCourse(_ folderToCourse: LinkCourseToFolder) throws {
        do {
            try firestoreService.remove(folderToCourse, collection: .folderToCourseLinks)
        } catch { throw error }
    }
    
    
    // course to folder link
    func createCourseToFolderLink(_ link: LinkCourseToFolder) async throws {
        do {
            try await firestoreService.create(link, collection: .folderToCourseLinks)
        } catch { throw error }
    }
    
    func coursesInFolder(folderId: String) async throws -> [Course] {
        do {
            let links = try await firestoreService.getAllByKey(collection: .folderToCourseLinks, type: LinkCourseToFolder.self, key: "folderId", value: folderId)
            var courses = [Course]()
            for link in links {
                if let course = try await firestoreService.getOneById(collection: .courses, type: Course.self, id: link.courseId) {
                    courses.append(course)
                }
            }
            return courses
        } catch { throw error }
    }
    
    func listAllCoursesInFolder(folderId: String) async throws -> [LinkCourseToFolder] {
        do {
            let foldersToCourses = try await firestoreService.getAllByKey(collection: .folderToCourseLinks, type: LinkCourseToFolder.self, key: "folderId", value: folderId, order: "sequence")
            return foldersToCourses
        } catch { throw error
        }
    }
    
    func getFile() {
//        // Create a reference to the file you want to download
//        let islandRef = storageRef.child("images/island.jpg")
//        
//        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//            if let error = error {
//                // Uh-oh, an error occurred!
//            } else {
//                // Data for "images/island.jpg" is returned
//                let image = UIImage(data: data!)
//            }
//        }
    }
    
}
