//
//  MediaView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/16/21.
//

import SwiftUI

struct MediaView: View {
    
    @State private var entries = [CloudFile]()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack {
                    PrettyLink(label: "Folders", destination: FoldersView()) { }
                    Spacer()
                }
                HStack {
                    PrettyLink(label: "Items", destination: ItemsView()) { }
                    Spacer()
                }
                HStack {
                    PrettyLink(label: "Cloud Files", destination: CloudFilesView()) { }
                    Spacer()
                }
            }
            .padding(20)
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
