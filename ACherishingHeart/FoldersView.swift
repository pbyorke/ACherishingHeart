//
//  FoldersView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/17/21.
//

import SwiftUI

struct FoldersView: View {
    
    @EnvironmentObject var storageService: StorageService

    @State private var albums = [Folder]()
    @State private var folder = Folder.new
    
    var body: some View {
        HStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(albums) { folder in
                        PrettyLink(label: folder.name, destination: FolderView(add: false, folder: $folder)) { self.folder = folder }
                    }
                }
            }
        }
        .padding()
        .navigationTitle( Text("Folders") )
        .font(.title2)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: FolderView(add: true, folder: $folder)) {
                    Image(systemName: "plus")
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
    }
    
}

#if DEBUG
struct FoldersView_Previews: PreviewProvider {
    static var previews: some View {
        FoldersView()
    }
}
#endif
