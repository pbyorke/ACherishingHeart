//
//  AlbumsView.swift
//  AlbumsView
//
//  Created by Peter Yorke on 8/17/21.
//

import SwiftUI

struct AlbumsView: View {
    
    var storageService: StorageServiceProtocol = StorageService.shared
    
    @State private var albums = [Album]()
    
    var body: some View {
        HStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(albums) { album in
                        HStack {
                            NavigationLink(destination: AlbumView()) {
                                Text(album.name)
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle( Text("Albums") )
        .font(.title2)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AlbumView()) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            Task.init {
                do {
                    self.albums = try await storageService.listAllAlbums()
                }
            }
        }
    }
    
}

#if DEBUG
struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsView()
    }
}
#endif
