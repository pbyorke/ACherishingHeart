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
    
    var body: some View {
        HStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(albums) { album in
                        PrettyLink(label: album.name, destination: FolderView()) { }
                    }
                }
            }
        }
        .padding()
        .navigationTitle( Text("Folders") )
        .font(.title2)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: FolderView()) {
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
