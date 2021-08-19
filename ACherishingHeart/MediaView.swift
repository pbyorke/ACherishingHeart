//
//  MediaView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/16/21.
//

import SwiftUI

struct MediaView: View {
    
    var storageService: StorageServiceProtocol = StorageService.shared
    @State private var entries = [Entry]()
    
    var body: some View {
        TabView {
            AlbumsView()
                .tabItem{Label("Albums", systemImage: "doc.on.doc") }
            SongsView()
                .tabItem{Label("Songs", systemImage: "doc") }
        }
        .navigationTitle(Text("Media Master"))
//        List {
//            ForEach(entries) { entry in
//                HStack {
//                    Text(entry.name)
//                    Spacer()
//                    Text(entry.bucket)
//                }
//            }
//        }
//        .padding()
//        .navigationTitle(Text("Songs in cloud"))
//        .task {
//            self.entries = await storageService.listAllMusic()
//        }
    }
}

struct MediaView_Previews: PreviewProvider {
    static var previews: some View {
        MediaView()
    }
}
