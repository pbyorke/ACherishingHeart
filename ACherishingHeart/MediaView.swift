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
        HStack {
            ScrollView {
                VStack {
                    VStack(spacing: 10) {
                        PrettyLink(text: "Albums", action: AlbumsView())
                        PrettyLink(text: "Songs", action: SongsView())
                        Spacer()
                    }
                    .padding(20)
                }
            }
        }
        .navigationTitle( Text("Media Administrator") )
        .font(.title2)
    }
}

#if DEBUG
struct MediaView_Previews: PreviewProvider {
    static var previews: some View {
        MediaView()
    }
}
#endif
