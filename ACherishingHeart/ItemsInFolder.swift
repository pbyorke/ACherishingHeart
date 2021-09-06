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

    func dump() {
        print("* * *  Items.dump()")
        for item in items {
            print("  * * *  \(item)")
        }
    }
    
}
