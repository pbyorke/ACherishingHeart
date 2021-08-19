//
//  SongsView.swift
//  SongsView
//
//  Created by Peter Yorke on 8/17/21.
//

import SwiftUI

struct SongsView: View {
    
    var storageService: StorageServiceProtocol = StorageService.shared
    @State private var songs = [Song]()
    
    var body: some View {
        List {
            ForEach(songs) { song in
                HStack {
                    Text(song.name)
                }
            }
        }
        .padding()
        .navigationTitle(Text("Songs in cloud"))
        .onAppear {
            Task.init {
                do {
                    self.songs = try await storageService.listAllSongs()
                }
            }
        }
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView()
    }
}
