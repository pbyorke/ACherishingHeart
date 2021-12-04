//
//  MusicListView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 11/20/21.
//

import SwiftUI

struct MusicListView: View {
    
    @StateObject private var viewModel = MusicListModel()
    
    @State private var folder = Folder.new
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(viewModel.albums) { album in
                    HStack {
                        NavigationLink(destination: MusicPlayerView(folder: album)) { Text(album.name) }
                        Spacer()
                    }
                }
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
        .navigationTitle( Text("Albums") )
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        if MainView.NAMES {
            Names(name: "MusicListView")
        } // NAMES
    }
}

struct MusicListView_Previews: PreviewProvider {
    
    static var previews: some View {
        MusicListView()
    }
}
