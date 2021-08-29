//
//  ItemsInFolderView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/27/21.
//

import SwiftUI

struct ItemsInFolderView: View {
    
    var storageService: StorageServiceProtocol = StorageService.shared

    @Binding var folder: Folder
    @State private var items = [Item]()

    var body: some View {
        VStack {
            ZStack {
                Text("Items in this Folder").font(.title)
                HStack {
                    Spacer()
                    PrettyLink(image: "plus", destination: AddItemsView(folder: $folder)) { }
                }
            }
            List(items, id: \.id) { item in
                Text("\(item.name)")
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Swipe(symbol: "minus.square.fill", color: .red) { delete(item: item) }
                        Swipe(symbol: "arrow.down.square.fill", color: .green) { moveDown(item: item) }
                        Swipe(symbol: "arrow.up.square.fill", color: .green) { moveUp(item: item) }
                    }
            }
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .font(.body)
        .task {
            do {
                let array = try await storageService.itemsInFolder(folderId: folder.id)
                DispatchQueue.main.async {
                    self.items = array
                }
            } catch { }
        }
    }
    
    private func delete(item: Item) {
        print("* * *  delete")
    }
    
    private func  moveUp(item: Item) {
        print("* * *  up")
    }
    
    private func  moveDown(item: Item) {
        print("* * *  down")
    }
    
}

#if DEBUG
struct ItemsInFolderView_Previews: PreviewProvider {
    @State static var folder = Folder.new
    static var previews: some View {
        ItemsInFolderView(folder: $folder)
    }
}
#endif
