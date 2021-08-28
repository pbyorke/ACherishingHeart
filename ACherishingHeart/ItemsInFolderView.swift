//
//  ItemsInFolderView.swift
//  ItemsInFolderView
//
//  Created by Pete Yorke on 8/27/21.
//

import SwiftUI

struct ItemsInFolderView: View {
    
    @EnvironmentObject var storageService: StorageService
    
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
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(items) { item in
                        HStack {
                            Text("\(item.name)")
                            Spacer()
                            Text("\(item.bucket)")
                        }
                    }
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
    
}

#if DEBUG
struct ItemsInFolderView_Previews: PreviewProvider {
    @State static var folder = Folder.new
    static var previews: some View {
        ItemsInFolderView(folder: $folder)
    }
}
#endif
