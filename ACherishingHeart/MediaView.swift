//
//  MediaView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/16/21.
//

import SwiftUI

struct MediaView: View {
    
    @EnvironmentObject var storageService: StorageService

    @State private var entries = [CloudFile]()
    
    var body: some View {
        HStack {
            ScrollView {
                VStack {
                    VStack(spacing: 10) {
                        PrettyLink(label: "Folders", destination: FoldersView()) { }
                        PrettyLink(label: "Items", destination: ItemsView()) { }
                        PrettyLink(label: "Cloud Files", destination: CloudFilesView()) { }
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
