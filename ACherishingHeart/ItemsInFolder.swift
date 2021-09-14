//
//  ItemsInFolder.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 9/5/21.
//

import Foundation

class ItemsInFolder: ObservableObject {
    
    @Published var items = [Item]()
    private var folder: Folder?
    var storageService: StorageServiceProtocol = StorageService.shared

    init() {
        items = [Item]()
    }
    
    func setup(_ folder: Folder) {
        self.folder = folder
        initialize()
    }
    
    private func initialize() {
        guard let folder = folder else { return }
        Task.init {
            do {
                let items = try await storageService.itemsInFolder(folderId: folder.id)
                DispatchQueue.main.async {
                    self.items = items
                }
            } catch { }
        }
    }
    
    func append(_ item: Item) {
        items.append(item)
    }
    
    subscript(index: Int) -> Item {
        get { return items[index] }
        set(newValue) { items[index] = newValue }
    }
    
    func delete(item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    func up(item: Item) {
        if let index = items.firstIndex(of: item) {
            if index > 0 {
                items.remove(at: index)
                items.insert(item, at: index - 1)
            }
        }
    }
    
    func down(item: Item) {
        if let index = items.firstIndex(of: item) {
            if index < items.count - 1 {
                items.remove(at: index)
                items.insert(item, at: index + 1)
            }
        }
    }
    
    func rewrite() async throws {
        do {
            if let folder = folder {
                let links = try await storageService.listAllItemsInFolder(folderId: folder.id)
                for link in links {
                    try storageService.removeItemToFolderLink(link)
                }
                var index = 0
                for item in items {
                    try await storageService.createItemToFolderLink(
                        LinkItemToFolder(
                            id: "",
                            folderId: folder.id,
                            folderName: folder.name,
                            itemId: item.id,
                            itemName: item.name,
                            sequence: index
                        )
                    )
                    index += 1
                }
            }
        } catch { throw error }
    }
    
    func dump() {
        print("* * *  Items.dump()")
        for item in items {
            print("  * * *  \(item)")
        }
    }
    
}
