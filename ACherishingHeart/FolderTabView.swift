//
//  FolderTabView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/19/21.
//

import SwiftUI

struct FolderTabView: View {
    
    @EnvironmentObject var itemsInFolder: ItemsInFolder
    @EnvironmentObject var coursesInFolder: CoursesInFolder
    var storageService: StorageServiceProtocol = StorageService.shared
    
    var add = false
    @Binding var folder: Folder
    
    var body: some View {
        TabView {
            FolderInfoView(folder: $folder).tabItem { Label("Info", systemImage: "gearshape.fill")  }
            FolderItemsView().tabItem { Label("Items", systemImage: "music.note") }
            FolderCoursesView().tabItem { Label("Courses", systemImage: "books.vertical.fill") }
            .navigationTitle("Folder")
        }
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
struct FolderTabView_Previews: PreviewProvider {
    @State static var folder = Folder.new
    static var previews: some View {
        FolderTabView(add: false, folder: $folder)
            .preview(with: "Add or update a Folder")
    }
}
#endif
