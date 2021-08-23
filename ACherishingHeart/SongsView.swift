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
        HStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(songs) { song in
                        PrettyLink(text: song.name, action: SongView())
                    }
                }
            }
        }
        .padding()
        .navigationTitle( Text("Songs") )
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
                    self.songs = try await storageService.listAllSongs()
                }
            }
        }
    }
    
}

#if DEBUG
struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView()
    }
}
#endif
