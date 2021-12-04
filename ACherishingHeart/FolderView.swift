//
//  FolderView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/19/21.
//

import SwiftUI

enum FolderType {
    case play
    case edit
}

enum FolderEditType {
    case add
    case update
}

struct FolderView: View {
    
    @EnvironmentObject var itemsInFolder: ItemsInFolder
    @EnvironmentObject var coursesInFolder: CoursesInFolder
    var storageService: StorageServiceProtocol = StorageService.shared
    
    var add = false
    var type: FolderType
    @Binding var folder: Folder
    
    var body: some View {
        if type == .edit {
            FolderTabView(folder: $folder)
//            TabView {
//                FolderInfoView(folder: $folder).tabItem { Label("Info", systemImage: "gearshape.fill")  }
//                FolderItemsView().tabItem { Label("Items", systemImage: "music.note") }
//                FolderCoursesView().tabItem { Label("Courses", systemImage: "books.vertical.fill") }
//                .navigationTitle("Folder")
//            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: update) {
                        if add {
                            Image(systemName: "plus")
                        } else {
                            Image(systemName: "square.and.arrow.down")
                        }
                    }
                }
            }
        } else {
//            ScrollView {
//                VStack(spacing: 10) {
//                    ForEach(itemsInFolder.items) { item in
//                        PrettyLink(label: item.name), spacer: true, destination: Text(item.name) { }
//                    }
//                }
//            }
            FolderItemsView()
        }
        if MainView.NAMES {
            Names(name: "FolderTabView")
        } // NAMES
    }
    
    private func update() {
        Task.init {
            do {
                try await itemsInFolder.rewrite()
                try await coursesInFolder.rewrite()
                if add {
                    try await storageService.createFolder(folder)
                } else {
                    try storageService.updateFolder(folder)
                }
            } catch { }
        }
    }
    
}

#if DEBUG
struct FolderView_Previews: PreviewProvider {
    @State static var folder = Folder.new
    static var previews: some View {
        FolderView(add: false, type: .play, folder: $folder)
            .preview(with: "Add or update a Folder")
    }
}
#endif
