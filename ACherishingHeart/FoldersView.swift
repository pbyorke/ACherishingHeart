//
//  FoldersView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/17/21.
//

import SwiftUI

struct FoldersView: View {
    
    var storageService: StorageServiceProtocol = StorageService.shared
    @EnvironmentObject var itemsInFolder: ItemsInFolder
    @EnvironmentObject var coursesInFolder: CoursesInFolder

    @State private var albums = [Folder]()
    @State private var folder = Folder.new
    
    var type: FolderType
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(albums) { folder in
                    PrettyLink(label: folder.name, spacer: true, destination: FolderView(add: false, type: type, folder: $folder)) {
                        self.folder = folder
                        itemsInFolder.setup(folder)
                        coursesInFolder.setup(folder)
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle( Text("Folders") )
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if type == .edit {
                    NavigationLink(destination: FolderView(add: true, type: type, folder: $folder)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            Task.init {
                do {
                    self.albums = try await storageService.listAllFolders()
                }
            }
        }
        if MainView.NAMES {
            Names(name: "FoldersView")
        } // NAMES
    }
}

struct FoldersView_Previews: PreviewProvider {
    static var previews: some View {
        FoldersView(type: .play)
    }
}
