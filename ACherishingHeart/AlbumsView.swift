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
        List {
            ForEach(albums) { album in
                HStack {
                    Text(album.name)
                }
            }
        }
        .padding()
        .navigationTitle(Text("Albums in cloud"))
        .onAppear {
            Task.init {
                do {
                    self.albums = try await storageService.listAllAlbums()
                }
            }
        }
    }
}

struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsView()
    }
}
